//
//  UpdatePersonalInfoViewController.swift
//  Trajectory
//
//  Created by Andrew Vogel on 3/22/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import UIKit

class UpdatePersonalInfoViewController: UIViewController {

    lazy var userService: UserService = FirebaseUserService()
    lazy var authService: AuthenticationService = FirebaseAuthenticationService()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userService.getCurrentUser { (user, error) in
            self.userService.getCurrentUser { (user, error) in
                guard let user = user else { return }
                self.usersName.text = user.name
                self.usersEmailAddress.text = user.emailAddress
                self.usersPhoneNumber.text = user.phoneNumber
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    @IBOutlet weak var usersName: UITextField!
    @IBOutlet weak var usersEmailAddress: UITextField!
    @IBOutlet weak var usersPhoneNumber: UITextField!
    
    @IBOutlet weak var nameErrorMessage: UILabel!
    @IBOutlet weak var emailErrorMessage: UILabel!
    @IBOutlet weak var phoneNumberErrorMessage: UILabel!
    
    @IBAction func doneButton(_ sender: Any) {
        let user = User()
        let dispatch = DispatchGroup()
        //Variable that indicates whether screen should dismiss or not after running error checks
        var toDismiss = true
        //Error check for valid first and last name
        if usersName.text != nil && !(usersName.text?.trimmingCharacters(in: CharacterSet.whitespaces).isEmpty)! && (usersName.text?.contains(" "))! {
            user.name = usersName.text
            nameErrorMessage.isHidden = true
        } else {
            //Display error message if name is invalid
            nameErrorMessage.isHidden = false
            toDismiss = false
            usersName.becomeFirstResponder()
        }
        
        //Error check for valid email address
        guard let newEmail = usersEmailAddress.text else { return }
        user.emailAddress = newEmail
        dispatch.enter()
        authService.updateEmail(newEmail) { (error) in
            if error != nil {
                // issue with email or connectivity
                self.emailErrorMessage.isHidden = false
                toDismiss = false
                if !self.usersName.isFirstResponder {
                    self.usersEmailAddress.becomeFirstResponder()
                }
            }
            else {
                //make sure error message is hidden
                self.emailErrorMessage.isHidden = true
                // also save within user document
                user.emailAddress = self.usersEmailAddress.text
            }
            dispatch.leave()
            
        }
        
        //TODO: error check phone number
        user.phoneNumber = usersPhoneNumber.text
        
        //Save data and dismiss if all checks passed
        dispatch.notify(queue: .main) {
            if toDismiss == true {
                self.userService.saveCurrentUser(user, completion: nil)
                self.dismiss(animated: true, completion: nil)
            }
        }
        
        
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
