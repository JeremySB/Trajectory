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
    func getCurrentUser(_ completion: @escaping (User?, UserServiceError?) -> Void) {
        if let uid = Auth.auth().currentUser?.uid {
            getUser(uid: uid, completion: completion)
        }
        else {
            completion(nil, .NotLoggedIn)
        }
    }
    
    func getUser(uid: String, completion: @escaping (User?, UserServiceError?) -> Void) {
        Firestore.firestore().collection("users").document(uid).getDocument { (doc, error) in
            if let error = error {
                return completion(nil, UserServiceError.Misc(error.localizedDescription))
            }
            guard let data = doc?.data() else {
                completion(nil, UserServiceError.NoUserData)
                return
            }
            if let user = try? FirestoreDecoder().decode(User.self, from: data) {
                completion(user, nil)
            }
            else {
                completion(nil, UserServiceError.InvalidUserData)
            }
        }
    }
    
    func getMentee(uid: String, completion: @escaping (Mentee?, UserServiceError?) -> Void) {
        Firestore.firestore().collection("users").document(uid).getDocument { (doc, error) in
            if let error = error {
                return completion(nil, UserServiceError.Misc(error.localizedDescription))
            }
            guard let data = doc?.data() else {
                completion(nil, UserServiceError.NoUserData)
                return
            }
            if let mentee = try? FirestoreDecoder().decode(Mentee.self, from: data) {
                completion(mentee, nil)
            }
            else {
                completion(nil, UserServiceError.InvalidUserData)
            }
        }
    }
}
