//
//  FirebaseConnectionService.swift
//  Trajectory
//
//  Created by Jeremy Bost on 2/27/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import Firebase
import FirebaseFunctions
import CodableFirebase

class FirebaseConnectionService : ConnectionService {
    
    lazy var userService = FirebaseUserService()
    lazy var functions = Functions.functions()
    
    var listeners = [ListenerRegistration]()
    
    deinit {
        for listener in listeners {
            listener.remove()
        }
    }
    
    func accept(menteeRequest: MenteeRequest, until endDate: Date, completion: ((ConnectionServiceError?) -> Void)?) {
        guard let _ = Auth.auth().currentUser?.uid else {
            completion?(.NotLoggedIn)
            return
        }
        
        getConnection(menteeRequest.connectionId) { (connection, error) in
            if let connection = connection {
                connection.mentorStatus = .accepted
                connection.mentorshipEndDate = endDate
                self.saveConnection(connection, completion: { (error2) in
                    completion?(error2)
                })
            }
            else {
                completion?(error)
            }
        }
    }
    
    func decline(menteeRequest: MenteeRequest, completion: ((ConnectionServiceError?) -> Void)?) {
        guard let _ = Auth.auth().currentUser?.uid else {
            completion?(.NotLoggedIn)
            return
        }
        
        getConnection(menteeRequest.connectionId) { (connection, error) in
            if let connection = connection {
                connection.mentorStatus = .rejected
                self.saveConnection(connection, completion: { (error2) in
                    completion?(error2)
                })
            }
            else {
                completion?(error)
            }
        }
    }
    
    func set(endDate: Date, with mentee: User, completion: ((ConnectionServiceError?) -> Void)?) {
        guard let uid = Auth.auth().currentUser?.uid else {
            completion?(.NotLoggedIn)
            return
        }
        
        guard let menteeId = mentee.id else {
            completion?(.InvalidInputData)
            return
        }
        
        getConnectionBetween(mentee: menteeId, mentor: uid) { (connection, error) in
            if let connection = connection {
                connection.mentorStatus = .accepted
                connection.mentorshipEndDate = endDate
                self.saveConnection(connection, completion: { (error2) in
                    completion?(error2)
                })
            }
            else {
                completion?(error)
            }
        }
    }
    
    func saveConnection(_ connection: Connection, completion: ((ConnectionServiceError?) -> Void)?) {
        guard let id = connection.id, let connEncoded = try? FirestoreEncoder().encode(connection) else {
            completion?(.InvalidInputData)
            return
        }
        Firestore.firestore().collection(FirestoreValues.connectionCollection).document(id)
            .setData(connEncoded) { error in
                if let error = error {
                    completion?(.Misc(error.localizedDescription))
                } else {
                    completion?(nil)
                }
            }
    }
    
    func getConnection(_ id: String, completion: @escaping (Connection?, ConnectionServiceError?) -> Void) {
        Firestore.firestore().collection(FirestoreValues.connectionCollection).document(id).getDocument { (snapshot, error) in
            if let error = error {
                print("\(error)")
                completion(nil, .Misc(error.localizedDescription))
            }
            else if let data = snapshot?.data() {
                if let connDecoded = try? FirestoreDecoder().decode(Connection.self, from: data) {
                    connDecoded.id = snapshot?.documentID
                    completion(connDecoded, nil)
                }
                else {
                    completion(nil, .InvalidServerData)
                }
            }
        }
    }
    
    func getConnectionBetween(mentee menteeId: String, mentor mentorId: String, completion: @escaping (Connection?, ConnectionServiceError?) -> Void) {
        Firestore.firestore().collection(FirestoreValues.connectionCollection)
            .whereField(FirestoreValues.connectionMentee, isEqualTo: menteeId)
            .whereField(FirestoreValues.connectionMentor, isEqualTo: mentorId)
            .limit(to: 1)
            .getDocuments { (snapshot, error) in
                if let error = error {
                    print("\(error)")
                    completion(nil, .Misc(error.localizedDescription))
                    return
                }
                else if let snapshot = snapshot, let doc = snapshot.documents.first,
                    let connection = try? FirestoreDecoder().decode(Connection.self, from: doc.data()) {
                    connection.id = doc.documentID
                    completion(connection, nil)
                } else {
                    completion(nil, .InvalidServerData)
                }
        }
    }
    
    func sendMentorRequest(to mentor: String, completion: ((ConnectionServiceError?) -> Void)?) {
        guard let uid = Auth.auth().currentUser?.uid else {
            completion?(.NotLoggedIn)
            return
        }
        let conn = Connection()
        conn.mentee = uid
        conn.mentor = mentor
        conn.mentorStatus = .pending
        do {
            var connEncoded = try FirestoreEncoder().encode(conn)
            connEncoded[FirestoreValues.connectionSentRequestDate] = FieldValue.serverTimestamp()
            Firestore.firestore().collection(FirestoreValues.connectionCollection).document(uid+" "+mentor).setData(connEncoded, completion: { (error) in
                if let error = error {
                    completion?(.Misc(error.localizedDescription))
                } else {
                    completion?(nil)
                }
            })
        } catch {
            completion?(.Misc(error.localizedDescription))
        }
    }
    
    func addOpenMenteeRequestsListener(_ update: @escaping ([MenteeRequest]?, ConnectionServiceError?) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {
            update(nil, .NotLoggedIn)
            return
        }
        
        listeners.append(Firestore.firestore().collection(FirestoreValues.connectionCollection)
            .whereField(FirestoreValues.connectionMentor, isEqualTo: uid)
            .whereField(FirestoreValues.connectionMentorStatus, isEqualTo: Connection.Status.pending.rawValue)
            .addSnapshotListener { (snapshot, error) in
                if let error = error {
                    print("\(error)")
                    return update(nil, .Misc(error.localizedDescription))
                }
                guard let snapshot = snapshot else { return }
                
                var requests = [MenteeRequest]()
                let dispatch = DispatchGroup()
            
                for connection in snapshot.documents {
                    if let connectionDecoded = try? FirestoreDecoder().decode(Connection.self, from: connection.data()) {
                        dispatch.enter()
                        guard let menteeUid = connectionDecoded.mentee else { continue }
                        self.userService.getUser(uid: menteeUid, completion: { (user, error) in
                            if let user = user {
                                requests.append(MenteeRequest(by: user, with: connection.documentID))
                            }
                            dispatch.leave()
                        })
                    }
                }
                dispatch.notify(queue: .main, execute: {
                    update(requests, nil)
                })
        })
    }
    
    func addMenteesListener(_ update: @escaping ([User]?, ConnectionServiceError?) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {
            update(nil, .NotLoggedIn)
            return
        }
        let listener = Firestore.firestore().collection(FirestoreValues.connectionCollection)
            .whereField(Connection.CodingKeys.mentor.rawValue, isEqualTo: uid)
            .whereField(Connection.CodingKeys.mentorStatus.rawValue, isEqualTo: Connection.Status.accepted.rawValue)
            .whereField(Connection.CodingKeys.mentorshipEndDate.rawValue, isGreaterThan: Date())
            .addSnapshotListener({ (snapshot, error) in
                if let error = error {
                    print("\(error)")
                }
                guard let snapshot = snapshot else {
                    update([User](), nil)
                    return
                }
                var menteeIds = [String]()
                for connection in snapshot.documents {
                    guard let connectionDecoded = try? FirestoreDecoder().decode(Connection.self, from: connection.data()) else { continue }
                    guard let menteeId = connectionDecoded.mentee else { continue }
                    menteeIds.append(menteeId)
                }
                self.userService.getUsers(uids: menteeIds, completion: { (users, error) in
                    update(users, nil)
                })
            })
        listeners.append(listener)
    }
    
    func addMentorsListener(_ update: @escaping ([User]?, ConnectionServiceError?) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {
            update(nil, .NotLoggedIn)
            return
        }
        let listener = Firestore.firestore().collection(FirestoreValues.connectionCollection)
            .whereField(Connection.CodingKeys.mentee.rawValue, isEqualTo: uid)
            .whereField(FirestoreValues.connectionMentorStatus, isEqualTo: Connection.Status.accepted.rawValue)
            .whereField(Connection.CodingKeys.mentorshipEndDate.rawValue, isGreaterThan: Date())
            .addSnapshotListener({ (snapshot, error) in
                if let error = error {
                    print("\(error)")
                }
                guard let snapshot = snapshot else {
                    update([User](), nil)
                    return
                }
                var mentorIds = [String]()
                for connection in snapshot.documents {
                    guard let connectionDecoded = try? FirestoreDecoder().decode(Connection.self, from: connection.data()) else { continue }
                    guard let mentorId = connectionDecoded.mentor else { continue }
                    mentorIds.append(mentorId)
                }
                self.userService.getUsers(uids: mentorIds, completion: { (users, error) in
                    update(users, nil)
                })
            })
        listeners.append(listener)
    }
    
    func addCheckin(_ checkin: Checkin, with mentor: User, completion: ((ConnectionServiceError?) -> Void)?) {
        guard let uid = Auth.auth().currentUser?.uid else {
            completion?(.NotLoggedIn)
            return
        }
        guard let mentorId = mentor.id,
            var checkinEncoded = try? FirestoreEncoder().encode(checkin) else {
            completion?(.InvalidInputData)
            return
        }
        
        checkinEncoded[Checkin.CodingKeys.dateCreated.rawValue] = FieldValue.serverTimestamp()
        
        getConnectionBetween(mentee: uid, mentor: mentorId) { (connection, error) in
            guard let connectionId = connection?.id else {
                completion?(.Misc(error?.localizedDescription ?? ""))
                return
            }
            Firestore.firestore().collection(FirestoreValues.connectionCollection)
                .document(connectionId)
                .collection(FirestoreValues.connectionCheckinCollection)
                .addDocument(data: checkinEncoded, completion: { (error) in
                    
                })
        }
    }
    
    func addCheckinsListener(from menteeId: String, to mentorId: String, update: @escaping ([Checkin]?, ConnectionServiceError?) -> Void) {
        var checkins = [Checkin]()
        getConnectionBetween(mentee: menteeId, mentor: mentorId) { (connection, error) in
            if let connectionId = connection?.id {
                let listener = Firestore.firestore().collection(FirestoreValues.connectionCollection)
                    .document(connectionId)
                    .collection(FirestoreValues.connectionCheckinCollection)
                    .addSnapshotListener({ (snapshot, error) in
                        guard let snapshot = snapshot else {
                            update(nil, .Misc(error?.localizedDescription ?? ""))
                            return
                        }
                        for doc in snapshot.documents {
                            if let checkin = try? FirestoreDecoder().decode(Checkin.self, from: doc.data()) {
                                checkins.append(checkin)
                            }
                        }
                        update(checkins, nil)
                    })
                self.listeners.append(listener)
            }
            else {
                update(nil, .InvalidServerData)
            }
        }
    }
    
    func addLatestCheckinListener(from menteeId: String, to mentorId: String, update: @escaping (Checkin?, ConnectionServiceError?) -> Void) {
        getConnectionBetween(mentee: menteeId, mentor: mentorId) { (connection, error) in
            if let connectionId = connection?.id {
                let listener = Firestore.firestore().collection(FirestoreValues.connectionCollection)
                    .document(connectionId)
                    .collection(FirestoreValues.connectionCheckinCollection)
                    .order(by: Checkin.CodingKeys.dateCreated.rawValue, descending: true)
                    .limit(to: 1)
                    .addSnapshotListener({ (snapshot, error) in
                        guard let checkinDoc = snapshot?.documents.first else {
                            update(nil, .Misc(error?.localizedDescription ?? ""))
                            return
                        }
                        if let checkin = try? FirestoreDecoder().decode(Checkin.self, from: checkinDoc.data()) {
                            update(checkin, nil)
                        }
                    })
                self.listeners.append(listener)
            }
            else {
                update(nil, .InvalidServerData)
            }
        }
    }
    
    func requestCheckin(from mentee: User, completion: ((ConnectionServiceError?) -> Void)? = nil) {
        guard let menteeId = mentee.id else { return }
        functions.httpsCallable("requestMenteeCheckin").call(["menteeId": menteeId]) { (result, error) in
            if let error = error as NSError? {
                print(error)
                completion?(.Misc(error.localizedDescription))
                if error.domain == FunctionsErrorDomain {
                    let _ = FIRFunctionsErrorCode(rawValue: error.code)
                    let _ = error.localizedDescription
                    let _ = error.userInfo[FunctionsErrorDetailsKey]
                }
            }
            else {
                completion?(nil)
            }
        }
    }
    
    func requestNewEndDate(from mentor: User, completion: ((ConnectionServiceError?) -> Void)? = nil) {
        guard let mentorId = mentor.id else { return }
        functions.httpsCallable("requestNewMentorshipEndDate").call(["mentorId": mentorId]) { (result, error) in
            if let error = error as NSError? {
                print(error)
                completion?(.Misc(error.localizedDescription))
                if error.domain == FunctionsErrorDomain {
                    let _ = FIRFunctionsErrorCode(rawValue: error.code)
                    let _ = error.localizedDescription
                    let _ = error.userInfo[FunctionsErrorDetailsKey]
                }
            }
            else {
                completion?(nil)
            }
        }
    }
}
