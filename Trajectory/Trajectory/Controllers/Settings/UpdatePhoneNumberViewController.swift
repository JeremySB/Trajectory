//
//  UpdatePhoneNumberViewController.swift
//  Trajectory
//
//  Created by Andrew Vogel on 1/25/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import UIKit

class UpdatePhoneNumberViewController: UIViewController {
    
    lazy var userService: UserService = FirebaseUserService()

    override func viewDidLoad() {
        super.viewDidLoad()

        userService.getCurrentUser { (user, error) in
            if let user = user {
                self.userPhoneNumber.text = user.phoneNumber
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
    
    @IBOutlet weak var userPhoneNumber: UITextField!
    @IBOutlet weak var phoneNumberErrorMessage: UILabel!
    
    @IBAction func doneButton(_ sender: Any) {
        let user = User()
        user.phoneNumber = userPhoneNumber.text
        userService.saveCurrentUser(user, completion: nil)
        dismiss(animated: true, completion: nil)
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
