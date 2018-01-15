//
//  FirstViewController.swift
//  Trajectory
//
//  Created by Jeremy Bost on 12/24/17.
//  Copyright © 2017 Recreational Hazard. All rights reserved.
//

import UIKit
import FirebaseAuth

class FirstViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func logoutDidTouch() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            
            self.performSegue(withIdentifier: "FirstToLogin", sender: nil)
        }
        catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
    }

}

