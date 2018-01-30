//
//  UserNameViewController.swift
//  Trajectory
//
//  Created by Andrew Vogel on 1/24/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import UIKit
import Firebase

class UserNameViewController: UIViewController {
    
    //Array of user profile information to be collected
    var userData : [String] = ["name", "phoneNumber", "emailAddress", "hobbies", "professionalInterests", "denomination", "objectiveStatement"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.title = "Profile Setup"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var userName: UITextField!
    
    @IBAction func didTapNext(_ sender: Any) {
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = userName.text
        changeRequest?.commitChanges { (error) in
            if error == nil {
                self.performSegue(withIdentifier: "nameToPhoneAndEmail", sender: self)
            }
        }
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.destination is PhoneEmailViewController {
            //Copy validated user input into user profile array
            userData[0] = userName.text!
            //Pass user profile array
            let vc = segue.destination as? PhoneEmailViewController
            vc?.userData = userData
        }
    }
}
