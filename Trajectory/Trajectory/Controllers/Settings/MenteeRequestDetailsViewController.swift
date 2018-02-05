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
        userDetails.text = "Hobbies" + "\n\n" + String(describing: menteeRequest?.mentee.hobbies) + "\n\n" + "Professional Interests" + "\n\n" + String(describing: menteeRequest?.mentee.professionalInterests) + "\n\n" + "Denomination" + "\n\n" + String(describing: menteeRequest?.mentee.denomination) + "\n\n" + "Things to Work On" + "\n\n" + String(describing: menteeRequest?.mentee.menteeObjectives) + "\n\n" + "Contact" + "\n\n" + String(describing: menteeRequest?.mentee.phoneNumber) + "\n" + String(describing: menteeRequest?.mentee.emailAddress)
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
    
    @IBOutlet weak var userDetails: UITextView!
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let destinationVC = segue.destination as! SetDurationViewController
        destinationVC.menteeRequest = menteeRequest
    }
    

}
