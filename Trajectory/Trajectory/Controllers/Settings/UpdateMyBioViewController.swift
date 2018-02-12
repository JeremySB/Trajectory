//
//  UpdateMyBioViewController.swift
//  Trajectory
//
//  Created by Andrew Vogel on 1/25/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import UIKit

class UpdateMyBioViewController: UIViewController {
    
    var menteeRequest: MenteeRequest?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        userHobbies.text = menteeRequest?.mentee.hobbies
        userProfessionalInterests.text = menteeRequest?.mentee.professionalInterests
        userDenomination.text = menteeRequest?.mentee.denomination
        userObjectiveStatement.text = menteeRequest?.mentee.objectives
        
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
    
    @IBAction func doneButton(_ sender: Any) {
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
