//
//  LoginViewController.swift
//  Trajectory
//
//  Created by Jeremy Bost on 1/14/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import UIKit
import FirebaseAuthUI
import FirebaseGoogleAuthUI

class LoginViewController: UIViewController, FUIAuthDelegate {
    func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?) {
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if Auth.auth().currentUser == nil {
            // Need to login
            
            let authUI = FUIAuth.defaultAuthUI()
            authUI?.delegate = self
            let providers: [FUIAuthProvider] =  [
                FUIGoogleAuth()
            ]
            authUI?.providers = providers
            
            let authViewController = authUI!.authViewController()
            
            self.present(authViewController, animated: false, completion: nil)
        }
        else {
            self.performSegue(withIdentifier: "LoginToMain", sender: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
