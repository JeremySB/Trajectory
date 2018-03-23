//
//  PasswordAuthenticationViewController.swift
//  Trajectory
//
//  Created by Jeremy Bost on 1/29/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import UIKit
import FirebaseAuth

class PasswordAuthenticationViewController: UIViewController {
    
    var userEmail: String?
    
    var authService: AuthenticationService = FirebaseAuthenticationService()

    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var incorrectPasswordMessage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordField.attributedPlaceholder = NSAttributedString(string: "Password",
                                                              attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])

        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    // 3 basis
    // userEmail = nil, password incorrect, password correct
    @IBAction func didTapNext(_ sender: Any) {
        guard userEmail != nil && userEmail != "" else {
            self.navigationController?.popViewController(animated: false)
            return
        }
        Auth.auth().signIn(withEmail: userEmail!, password: passwordField.text!) { (user, error) in
            if let error = error {
                print(error.localizedDescription)
                self.passwordField.text = ""
                self.incorrectPasswordMessage.isHidden = false
                self.passwordField.becomeFirstResponder()
                return
            }
            
            // logged in
            self.performSegue(withIdentifier: "passwordToMain", sender: self)
        }
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
