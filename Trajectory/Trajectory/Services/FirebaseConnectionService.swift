//
//  FirebaseConnectionService.swift
//  Trajectory
//
//  Created by Jeremy Bost on 2/27/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import Firebase
import CodableFirebase

class FirebaseConnectionService : ConnectionService {
    lazy var userService = FirebaseUserService()
    
    var listeners = [ListenerRegistration]()
    
    deinit {
        for listener in listeners {
            listener.remove()
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
        conn.mentorAccepted = false
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
        
        listeners.append(Firestore.firestore().collection(FirestoreValues.connectionCollection).whereField("mentor", isEqualTo: uid).addSnapshotListener { (snapshot, error) in
            if let error = error {
                return update(nil, .Misc(error.localizedDescription))
            }
            guard let snapshot = snapshot else { return }
            
            var requests = [MenteeRequest]()
            let dispatch = DispatchGroup()
        
            for connection in snapshot.documents {
                if let connectionDecoded = try? FirestoreDecoder().decode(Connection.self, from: connection.data()) {
                    dispatch.enter()
                    guard let menteeUid = connectionDecoded.mentee else { continue }
                    self.userService.getMentee(uid: menteeUid, completion: { (mentee, error) in
                        if let mentee = mentee {
                            requests.append(MenteeRequest(by: mentee))
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
}
