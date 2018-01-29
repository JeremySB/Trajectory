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
        guard emailField?.text != nil else {
            return
        }
        guard validateEmail(enteredEmail: (emailField?.text)!) else {
            return
        }
        
        Auth.auth().fetchProviders(forEmail: (emailField?.text)!) { (providers, error) in
            if let error = error {
                print(error.localizedDescription)
                //let errorCode = AuthErrorCode(rawValue: error.code)
            }
            else if providers?.contains("password") ?? false {
                self.performSegue(withIdentifier: "passwordLogin", sender: self)
            }
            else {
                self.performSegue(withIdentifier: "passwordRegister", sender: self)
            }
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
    
    // Source: https://stackoverflow.com/a/35789191
    func validateEmail(enteredEmail:String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: enteredEmail)
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let dest = segue.destination as? PasswordAuthenticationViewController {
            dest.userEmail = emailField?.text
        }
        else if let dest = segue.destination as? NewPasswordViewController {
            dest.userEmail = emailField?.text
        }
    }


}
