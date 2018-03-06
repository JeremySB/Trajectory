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
        
        goalEncoded["dateCreated"] = FieldValue.serverTimestamp()
        
        db.collection(FirestoreValues.goalCollection).addDocument(data: goalEncoded)
        
        completion?(nil)
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
