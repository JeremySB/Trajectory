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
            let connEncoded = try FirestoreEncoder().encode(conn)
            Firestore.firestore().collection("connections").addDocument(data: connEncoded, completion: { (error) in
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
    
    
}
