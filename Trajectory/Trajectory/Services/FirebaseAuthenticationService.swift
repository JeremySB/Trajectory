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
            let vc = UIStoryboard(name: "Authentication", bundle: nil).instantiateInitialViewController()
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
    
    func updateEmail(_ email: String, completion: @escaping (AuthenticationError?) -> Void) {
        Auth.auth().currentUser?.updateEmail(to: email, completion: { (error) in
            if let error = error {
                if let authError = AuthErrorCode(rawValue: error._code) {
                    switch authError {
                    case .requiresRecentLogin:
                        completion(.ReauthenticationRequired)
                    default:
                        completion(.InvalidEmail(error.localizedDescription))
                    }
                }
                else {
                    completion(.InvalidEmail(error.localizedDescription))
                }
                
            } else {
                completion(nil)
            }
        })
    }
    
    func reauthenticateWith(password: String, completion: @escaping (AuthenticationError?) -> Void) {
        guard let user = Auth.auth().currentUser, let email = user.email else {
            completion(.NotLoggedIn)
            return
        }
        
        fetchProviders(forEmail: email) { (providers, error) in
            if let providers = providers, providers.contains("password") {
                let cred = EmailAuthProvider.credential(withEmail: email, password: password)
                
                user.reauthenticate(with: cred) { (error) in
                    if let error = error {
                        completion(.MiscError(error.localizedDescription))
                    }
                    else {
                        completion(nil)
                    }
                }
            }
            else {
                // uses some other form of auth, so force sign out
                if self.signOut() {
                    return
                }
            }
        }
        
        
    }
}
