//
//  NewPasswordViewController.swift
//  Trajectory
//
//  Created by Jeremy Bost on 1/29/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import UIKit
import FirebaseAuth

class NewPasswordViewController: UIViewController {
    
    lazy var userService: UserService = FirebaseUserService()
    var userEmail: String?

    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var createAccountBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createAccountBtn.layer.borderColor = UIColor.lightGray.cgColor
        createAccountBtn.layer.borderWidth = 2
        createAccountBtn.layer.cornerRadius = 5
        
        passwordField.attributedPlaceholder = NSAttributedString(string: "Password",
                                                                 attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    @IBOutlet weak var invalidPasswordMessage: UILabel!
    
    
    @IBAction func didTapCreateAccount(_ sender: Any) {
        guard userEmail != nil else {
            self.navigationController?.popViewController(animated: false)
            return
        }
        guard passwordField?.text != nil else {
            return
        }
        Auth.auth().createUser(withEmail: userEmail!, password: (passwordField?.text)!) { (user, error) in
            if let error = error {
                print(error.localizedDescription)
                self.invalidPasswordMessage.isHidden = false
                self.passwordField.becomeFirstResponder()
                return
            }
            
            self.userService.getCurrentUser({ (user, error) in
                if let user = user {
                    user.emailAddress = self.userEmail
                    self.userService.saveCurrentUser(user, completion: nil)
                }
            })
            
            // created account
            self.performSegue(withIdentifier: "newPasswordToName", sender: self)
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
