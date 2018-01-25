//
//  DenominationAndProfileGoalsViewController.swift
//  Trajectory
//
//  Created by Andrew Vogel on 1/23/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import UIKit
import FirebaseAuth

class DenominationAndProfileGoalsViewController: UIViewController {

    //Array of user's profile information, which is based on information from previous screen
    var userData: [String] = ["empty"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.title = "Profile Setup"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func register(_ sender: Any) {
        Auth.auth().signInAnonymously { (_, _) in
            let user = Auth.auth().currentUser
            user?.updateEmail(to: self.userData[2], completion: nil)
            
        }
    }
    
    @IBOutlet weak var denomination: UITextField!
    @IBOutlet weak var objectivesStatement: UITextView!
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        //Copy validated user input into user profile array
        userData[5] = denomination.text!
        userData[6] = objectivesStatement.text!
    }

}
