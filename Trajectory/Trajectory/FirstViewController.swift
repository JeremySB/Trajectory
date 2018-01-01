//
//  FirstViewController.swift
//  Trajectory
//
//  Created by Jeremy Bost on 12/24/17.
//  Copyright © 2017 Recreational Hazard. All rights reserved.
//

import UIKit
import FirebaseAuthUI
import FirebaseGoogleAuthUI

class FirstViewController: UIViewController, FUIAuthDelegate {
    func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?) {
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let authUI = FUIAuth.defaultAuthUI()
        authUI?.delegate = self
        let providers: [FUIAuthProvider] =  [
            FUIGoogleAuth()
        ]
        authUI?.providers = providers
        
        let authViewController = authUI!.authViewController()
        
        self.present(authViewController, animated: false, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

