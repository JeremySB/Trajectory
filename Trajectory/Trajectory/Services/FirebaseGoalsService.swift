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
    func addGoal(_: Goal, completion: @escaping (GoalsServiceError?) -> Void) {
        
    }
    
    func getGoals(completion: @escaping ([Goal]?, GoalsServiceError?) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {
            completion(nil, .NotLoggedIn)
            return
        }
        Firestore.firestore().collection("goals").whereField("owner", isEqualTo: uid).getDocuments { (snapshot, error) in
            if let error = error {
                return completion(nil, .Misc(error.localizedDescription))
            }
            guard let snapshot = snapshot else {
                return
            }
        }
    }
    
    
}
