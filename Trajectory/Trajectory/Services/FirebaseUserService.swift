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
    func getUser(uid: String, completion: @escaping (User?, UserError?) -> Void) {
        Firestore.firestore().collection("users").document(uid).getDocument { (doc, error) in
            if let error = error {
                return completion(nil, UserError.Misc(error.localizedDescription))
            }
            guard let data = doc?.data() else {
                completion(nil, UserError.NoUserData)
                return
            }
            if let user = try? FirestoreDecoder().decode(User.self, from: data) {
                completion(user, nil)
            }
            else {
                completion(nil, UserError.InvalidUserData)
            }
        }
    }
    
    func getMentee(uid: String, completion: @escaping (Mentee?, UserError?) -> Void) {
        Firestore.firestore().collection("users").document(uid).getDocument { (doc, error) in
            if let error = error {
                return completion(nil, UserError.Misc(error.localizedDescription))
            }
            guard let data = doc?.data() else {
                completion(nil, UserError.NoUserData)
                return
            }
            if let mentee = try? FirestoreDecoder().decode(Mentee.self, from: data) {
                completion(mentee, nil)
            }
            else {
                completion(nil, UserError.InvalidUserData)
            }
        }
    }
}
