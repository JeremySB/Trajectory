//
//  FirebaseGoalsService.swift
//  Trajectory
//
//  Created by Jeremy Bost on 2/11/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import UIKit
import Firebase
import CodableFirebase

class FirebaseGoalsService: GoalsService {
    lazy var db = Firestore.firestore()
    
    var listeners = [ListenerRegistration]()
    
    deinit {
        for listener in listeners {
            listener.remove()
        }
    }
    
    func addGoalsListener(_ update: @escaping ([Goal]?, GoalsServiceError?) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {
            update(nil, .NotLoggedIn)
            return
        }
        
        let listener = db.collection(FirestoreValues.goalCollection).whereField("owner", isEqualTo: uid).addSnapshotListener { (snapshot, error) in
            if let error = error {
                return update(nil, .Misc(error.localizedDescription))
            }
            guard let snapshot = snapshot else {
                return
            }
            var goals = [Goal]()
            for goal in snapshot.documents {
                do {
                    let goalDecoded = try FirestoreDecoder().decode(Goal.self, from: goal.data())
                    goalDecoded.id = goal.documentID
                    goals.append(goalDecoded)
                }
                catch let error {
                    print("Failed to decode: ", error, goal.data())
                }
            }
            
            update(goals, nil)
        }
        
        listeners.append(listener)
    }
    
    func addGoal(_ goal: Goal, completion: ((GoalsServiceError?) -> Void)?) {
        guard let uid = Auth.auth().currentUser?.uid else {
            completion?(.NotLoggedIn)
            return
        }
        
        goal.owner = uid
        
        guard var goalEncoded = try? FirestoreEncoder().encode(goal) else {
            completion?(.InvalidData)
            return
        }
        
        goalEncoded[FirestoreValues.goalDateCreated] = FieldValue.serverTimestamp()
        
        db.collection(FirestoreValues.goalCollection).addDocument(data: goalEncoded)
        
        completion?(nil)
    }
    
    func editGoal(_ goal: Goal, completion: ((GoalsServiceError?) -> Void)?) {
        guard let _ = Auth.auth().currentUser?.uid else {
            completion?(.NotLoggedIn)
            return
        }
        guard let goalId = goal.id, var goalEncoded = try? FirestoreEncoder().encode(goal) else {
            completion?(.InvalidData)
            return
        }
        goalEncoded[FirestoreValues.goalDateUpdated] = FieldValue.serverTimestamp()
        db.collection(FirestoreValues.goalCollection).document(goalId).setData(goalEncoded) { (error) in
            if let error = error {
                completion?(.Misc(error.localizedDescription))
            }
            else {
                completion?(nil)
            }
        }
    }
    
    func removeGoal(_ goal: Goal, completion: ((GoalsServiceError?) -> Void)?) {
        /*guard let uid = Auth.auth().currentUser?.uid else{
            completion?(.NotLoggedIn)
            return
        }*/
        if Auth.auth().currentUser?.uid == nil {
            completion?(.NotLoggedIn)
            return
        }
        guard let id = goal.id else{
            completion?(.NotLoggedIn)
            return
        }
        db.collection("goals").document(id).delete { (error) in
            if let error = error {
                completion?(.Misc(error.localizedDescription))
            }
            completion?(nil)
        }
    }
    
    func getGoals(completion: @escaping ([Goal]?, GoalsServiceError?) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {
            completion(nil, .NotLoggedIn)
            return
        }
        db.collection(FirestoreValues.goalCollection).whereField("owner", isEqualTo: uid).getDocuments { (snapshot, error) in
            if let error = error {
                return completion(nil, .Misc(error.localizedDescription))
            }
            guard let snapshot = snapshot else {
                return
            }
            var goals = [Goal]()
            for goal in snapshot.documents {
                if let goalDecoded = try? FirestoreDecoder().decode(Goal.self, from: goal.data()) {
                    goalDecoded.id = goal.documentID
                    goals.append(goalDecoded)
                }
            }
            
            completion(goals, nil)
        }
    }
}
