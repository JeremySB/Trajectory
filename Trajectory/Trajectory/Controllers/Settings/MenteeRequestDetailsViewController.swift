//
//  MenteeRequestDetailsViewController.swift
//  Trajectory
//
//  Created by Andrew Vogel on 1/28/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import UIKit

class MenteeRequestDetailsViewController: UIViewController {
    
    var menteeRequest: MenteeRequest?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        nameLabel.text = menteeRequest?.mentee.name
        organizationlabel.text = menteeRequest?.mentee.organization
        userHobbies.text = menteeRequest?.mentee.hobbies
        userProfessionalInterests.text = menteeRequest?.mentee.professionalInterests
        userDenomination.text = menteeRequest?.mentee.denomination
        userObjectives.text = menteeRequest?.mentee.objectives
        userEmailAddress.text = "Email Address: " //+ String(description: menteeRequest?.mentee.userEmailAddress)
        userPhoneNumber.text = "Phone Number: " //+ String(description: menteeRequest?.mentee.userPhoneNumber)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func setEndDate(_ sender: Any) {
    }
    
    @IBAction func decline(_ sender: Any) {
        menteeRequest?.decline()
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var organizationlabel: UILabel!
    
    @IBOutlet weak var userHobbies: UITextView!
    
    @IBOutlet weak var userProfessionalInterests: UITextView!
    
    @IBOutlet weak var userDenomination: UILabel!
    
    @IBOutlet weak var userObjectives: UITextView!
    
    @IBOutlet weak var userEmailAddress: UILabel!
    
    @IBOutlet weak var userPhoneNumber: UILabel!
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let destinationVC = segue.destination as! SetDurationViewController
        destinationVC.menteeRequest = menteeRequest
    }
    

}
