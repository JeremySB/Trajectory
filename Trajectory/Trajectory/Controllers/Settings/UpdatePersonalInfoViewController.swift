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
    var user: User? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userService.getCurrentUser { (user, error) in
            self.userService.getCurrentUser { (user, error) in
                guard let user = user else { return }
                self.user = user
                self.usersName.text = user.name
                self.usersEmailAddress.text = user.emailAddress
                self.usersPhoneNumber.text = user.phoneNumber
            }
        }
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
    
    func formatInput() -> String {
        let rawNumber = usersPhoneNumber.text!
        
        let digits = rawNumber.flatMap{Int(String($0))}
        let areaCode = "\(digits[0])\(digits[1])\(digits[2])"
        let secondSet = "\(digits[3])\(digits[4])\(digits[5])"
        let thirdSet = "\(digits[6])\(digits[7])\(digits[8])\(digits[9])"
        
        let formattedNumber = "(\(areaCode))-\(secondSet)-\(thirdSet)"
        print(formattedNumber)
        return formattedNumber
    }
    
    @IBAction func doneButton(_ sender: Any) {
        let user = self.user ?? User()
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
        // only go through this if email changed
        if newEmail != user.emailAddress {
            dispatch.enter()
            authService.updateEmail(newEmail) { (error) in
                if let error = error {
                    if case .ReauthenticationRequired = error {
                        self.displayPasswordModal()
                    }
                    else {
                        // issue with email or connectivity
                        self.emailErrorMessage.isHidden = false
                    }
                    toDismiss = false
                    if !self.usersName.isFirstResponder {
                        self.usersEmailAddress.becomeFirstResponder()
                    }
                }
                else {
                    //make sure error message is hidden
                    self.emailErrorMessage.isHidden = true
                    // also save within user document
                    user.emailAddress = newEmail
                }
                dispatch.leave()
            }
        }
        
        //Error check phone number
        let num = Int((usersPhoneNumber.text ?? nil)!)
        let length = usersPhoneNumber.text?.count ?? 0
        if(length == 10 && num != nil) || (length == 14) || (length == 12) {
            phoneNumberErrorMessage.isHidden = true
            let formattedPhoneNumber = formatInput()
            user.phoneNumber = formattedPhoneNumber
        } else {
            toDismiss = false
            phoneNumberErrorMessage.isHidden = false
        }
        
        //Save data and dismiss if all checks passed
        dispatch.notify(queue: .main) {
            if toDismiss {
                self.userService.saveCurrentUser(user, completion: nil)
                self.dismiss(animated: true, completion: nil)
            }
        }
        
        
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // Set status bar to white text
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func displayPasswordModal() {
        //https://learnappmaking.com/uialertcontroller-alerts-swift-how-to/
        let alert = UIAlertController(title: "Reenter Password", message: "Please enter your account password", preferredStyle: .alert)
        
        //https://stackoverflow.com/questions/24190277/writing-handler-for-uialertaction
        alert.addAction(UIAlertAction(title: "Submit", style: .default, handler: { [weak alert] (_) in
            if let password = alert?.textFields![0].text {
                self.authService.reauthenticateWith(password: password, completion: { (error) in
                    if let _ = error {
                        self.displayPasswordModal()
                    }
                })
            }
        }))
            
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addTextField { (textField) in
            textField.isSecureTextEntry = true
            textField.placeholder = "Password"
        }

        self.present(alert, animated: true)
        
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
