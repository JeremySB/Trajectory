//
//  UpdateMyBioViewController.swift
//  Trajectory
//
//  Created by Andrew Vogel on 1/25/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import UIKit

class UpdateMyBioViewController: UIViewController {
    
    lazy var userService: UserService = FirebaseUserService()
    
    var menteeRequest: MenteeRequest?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        userService.getCurrentUser { (user, error) in
            if let user = user {
                self.userHobbies.text = user.hobbies
                self.userProfessionalInterests.text = user.professionalInterests
                self.userDenomination.text = user.denomination
                self.userObjectiveStatement.text = user.objectives
            }
        }
        
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

    @IBOutlet weak var userHobbies: UITextView!
    @IBOutlet weak var userProfessionalInterests: UITextView!
    @IBOutlet weak var userDenomination: UITextField!
    @IBOutlet weak var userObjectiveStatement: UITextView!
    
    @IBOutlet weak var objectivesErrorMessage: UILabel!
    
    
    @IBAction func doneButton(_ sender: Any) {
        //Check required field
        if userObjectiveStatement.text != "" && userObjectiveStatement.text != " " {
            let user = User()
            user.hobbies = userHobbies.text
            user.professionalInterests = userProfessionalInterests.text
            user.denomination = userDenomination.text
            user.objectives = userObjectiveStatement.text
            userService.saveCurrentUser(user, completion: nil)
            dismiss(animated: true, completion: nil)
        } else {
            objectivesErrorMessage.isHidden = false
        }
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // Set status bar to white text
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
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
