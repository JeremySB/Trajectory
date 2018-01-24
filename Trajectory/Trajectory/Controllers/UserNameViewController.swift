//
//  UserNameViewController.swift
//  Trajectory
//
//  Created by Andrew Vogel on 1/24/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import UIKit

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
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.destination is PhoneEmailViewController {
            let vc = segue.destination as? PhoneEmailViewController
            vc?.userData = userData
        }
    }
}
