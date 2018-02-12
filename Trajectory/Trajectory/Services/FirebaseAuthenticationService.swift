//
//  FirebaseAuthenticationService.swift
//  Trajectory
//
//  Created by Jeremy Bost on 2/9/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import UIKit
import Firebase
import CodableFirebase

class FirebaseAuthenticationService: AuthenticationService {
    func signIn(withEmail email: String, password: String, completion: ((Error) -> Void)?) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let error = error {
                completion?(AuthenticationError.MiscError(error.localizedDescription))
            }
        }
    }
    
    func signOut() -> Bool {
        do {
            try Auth.auth().signOut()
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InitialAuthenticationViewController") as! InitialAuthenticationViewController
            UIApplication.shared.keyWindow?.rootViewController = vc
            
            return true
        } catch _ {
            return false
        }
    }
    
    var signedIn: Bool {
        return Auth.auth().currentUser != nil
    }
    
    var currentUID: String? {
        return Auth.auth().currentUser?.uid
    }
    
    func fetchProviders(forEmail email: String, completion: @escaping ([String]?, AuthenticationError?) -> Void) {
        Auth.auth().fetchProviders(forEmail: email) { (providers, error) in
            if let error = error {
                completion(nil, AuthenticationError.MiscError(error.localizedDescription))
                return
            }
            completion(providers, nil)
        }
    }
}
