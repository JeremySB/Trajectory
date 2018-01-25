//
//  InitialLaunchViewController.swift
//  Trajectory
//
//  Created by Andrew Vogel on 1/23/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import UIKit
import FirebaseAuth

class InitialAuthenticationViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    
    @IBAction func continueButtonPrimaryActionTriggered(_ sender: Any) {
        Auth.auth().fetchProviders(forEmail: (emailField?.text)!) { (providers, error) in
            print(providers)
            self.performSegue(withIdentifier: "Register", sender: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
