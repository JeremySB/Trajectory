//
//  UpdateNameViewController.swift
//  Trajectory
//
//  Created by Andrew Vogel on 1/25/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import UIKit

class UpdateNameViewController: UIViewController {
    
    lazy var userService: UserService = FirebaseUserService()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        userService.getCurrentUser { (user, error) in
            if let user = user {
                self.usersName.text = user.name
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
    @IBOutlet weak var nameErrorMessage: UILabel!
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
     @IBAction func doneButton(_ sender: Any) {
        //Error check for valid first and last name before saving name
        if usersName.text != nil && !(usersName.text?.trimmingCharacters(in: CharacterSet.whitespaces).isEmpty)! && (usersName.text?.contains(" "))! {
            let user = User()
            user.name = usersName.text
            userService.saveCurrentUser(user, completion: nil)
            dismiss(animated: true, completion: nil)
        } else {
            //Display error message if name is invalid
            nameErrorMessage.isHidden = false
            usersName.becomeFirstResponder()
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
