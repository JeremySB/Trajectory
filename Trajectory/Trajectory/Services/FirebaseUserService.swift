//
//  FirebaseUserService.swift
//  Trajectory
//
//  Created by Jeremy Bost on 2/8/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import UIKit
import Firebase
import CodableFirebase

class FirebaseUserService: UserService {
    
    var listeners = [ListenerRegistration]()
    
    deinit {
        for listener in listeners {
            listener.remove()
        }
    }
    
    func getAllAvailableMentors(completion: @escaping ([User]?, UserServiceError?) -> Void) {
        Firestore.firestore().collection(FirestoreValues.userCollection)
            .whereField(User.CodingKeys.willingToMentor.rawValue, isEqualTo: true)
            .limit(to: 5000).getDocuments { (docs, error) in
            if let error = error {
                return completion(nil, UserServiceError.Misc(error.localizedDescription))
            }
            var users = [User]()
            for userSnap in docs!.documents {
                if let user = try? FirestoreDecoder().decode(User.self, from: userSnap.data()) {
                    user.id = userSnap.documentID
                    users.append(user)
                }
            }
            completion(users, nil)
        }
    }
    
    func saveCurrentUser(_ user: User, completion: ((UserServiceError?) -> Void)?) {
        guard let userEncoded = try? FirestoreEncoder().encode(user) else {
            completion?(.InvalidUserData)
            return
        }
        guard let uid = Auth.auth().currentUser?.uid else {
            completion?(.NotLoggedIn)
            return
        }
        Firestore.firestore().collection(FirestoreValues.userCollection).document(uid).setData(userEncoded, options: SetOptions.merge()) { (error) in
            if let error = error {
                print(error.localizedDescription)
                completion?(.Misc(error.localizedDescription))
            }
            else {
                completion?(nil)
            }
        }
    }
    
    func getCurrentUser(_ completion: @escaping (User?, UserServiceError?) -> Void) {
        if let uid = Auth.auth().currentUser?.uid {
            getUser(uid: uid, completion: completion)
        }
        else {
            completion(nil, .NotLoggedIn)
        }
    }
    
    func getUser(uid: String, completion: @escaping (User?, UserServiceError?) -> Void) {
        Firestore.firestore().collection(FirestoreValues.userCollection).document(uid).getDocument { (doc, error) in
            if let error = error {
                return completion(nil, UserServiceError.Misc(error.localizedDescription))
            }
            guard let data = doc?.data() else {
                // empty user
                let user = User()
                user.isNew = true
                user.id = uid
                completion(user, nil)
                return
            }
            if let user = try? FirestoreDecoder().decode(User.self, from: data) {
                // success
                user.id = doc?.documentID
                completion(user, nil)
            }
            else {
                completion(nil, UserServiceError.InvalidUserData)
            }
        }
    }
    
    func getUsers(uids: [String], completion: @escaping ([User]?, UserServiceError?) -> Void) {
        let dispatch = DispatchGroup()
        var users = [User]()
        for uid in uids {
            dispatch.enter()
            getUser(uid: uid, completion: { (user, error) in
                if let user = user {
                    users.append(user)
                }
                dispatch.leave()
            })
        }
        dispatch.notify(queue: .main) {
            completion(users, nil)
        }
    }
    
    func addCurrentUserListener(_ update: @escaping (User?, UserServiceError?) -> Void) {
        if let uid = Auth.auth().currentUser?.uid {
            addUserListener(uid: uid, update: update)
        }
        else {
            update(nil, .NotLoggedIn)
        }
    }
    
    func addUserListener(uid: String, update: @escaping (User?, UserServiceError?) -> Void) {
        let listener = Firestore.firestore().collection(FirestoreValues.userCollection).document(uid)
            .addSnapshotListener { (doc, error) in
            if let error = error {
                return update(nil, UserServiceError.Misc(error.localizedDescription))
            }
            guard let data = doc?.data() else {
                update(nil, .NoUserData)
                return
            }
            if let user = try? FirestoreDecoder().decode(User.self, from: data) {
                // success
                user.id = doc?.documentID
                update(user, nil)
            }
            else {
                update(nil, UserServiceError.InvalidUserData)
            }
        }
        listeners.append(listener)
    }
}
