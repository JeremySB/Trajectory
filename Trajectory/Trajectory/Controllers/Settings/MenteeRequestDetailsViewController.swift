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
    lazy var connService: ConnectionService = FirebaseConnectionService()
    lazy var imageService: ImageService = FirebaseImageService()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        nameLabel.text = menteeRequest?.mentee.name ?? "Error: No Name Found"
        if nameLabel.text == "" {nameLabel.text = "Error: No Name Found"}
        organizationlabel.text = menteeRequest?.mentee.lastOrganizationName ?? "No Organization"
        if organizationlabel.text == "" {organizationlabel.text = "No Organizations Listed"}
        userHobbies.text = menteeRequest?.mentee.hobbies ?? "No Hobbies Listed"
        if userHobbies.text == "" {userHobbies.text = "No Hobbies Listed"}
        userProfessionalInterests.text = menteeRequest?.mentee.professionalInterests ?? "No Professional Interests Listed"
        if userProfessionalInterests.text == "" {userProfessionalInterests.text = "No Professional Interests Listed"}
        userDenomination.text = menteeRequest?.mentee.denomination ?? "No Denomination Listed"
        if userDenomination.text == "" {userDenomination.text = "No Denomination Found"}
        userObjectives.text = menteeRequest?.mentee.objectives ?? "No Objectives Found"
        if userObjectives.text == "" {userObjectives.text = "No Objectives Found"}
        userEmailAddress.text = "Email Address: \(menteeRequest?.mentee.emailAddress ?? "No Email Address Found")"
        if userEmailAddress.text == "Email Address: " {userEmailAddress.text = "No Email Address Found"}
        userPhoneNumber.text = "Phone Number: \(menteeRequest?.mentee.phoneNumber ?? "No Phone Number Found")"
        if userPhoneNumber.text == "Phone Number: " {userPhoneNumber.text = "No Phone Number Found"}

        setEndDateBtn.layer.borderColor = UIColor.lightGray.cgColor
        setEndDateBtn.layer.borderWidth = 2
        setEndDateBtn.layer.cornerRadius = 5
        declineBtn.layer.borderColor = UIColor.lightGray.cgColor
        declineBtn.layer.borderWidth = 2
        declineBtn.layer.cornerRadius = 5
        
        if let uid = menteeRequest?.mentee.id {
            imageService.bindProfileImage(for: uid, to: self.profileImage)
        }
        
        self.profileImage.layer.cornerRadius = self.profileImage.frame.size.width / 2;
        self.profileImage.clipsToBounds = true;
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    // Set status bar to white text
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func setEndDate(_ sender: Any) {
    }
    
    @IBAction func decline(_ sender: Any) {
        if let menteeRequest = menteeRequest {
            connService.decline(menteeRequest: menteeRequest, completion: nil)
        }
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
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var setEndDateBtn: UIButton!
    
    @IBOutlet weak var declineBtn: UIButton!
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let destinationVC = segue.destination as! SetDurationViewController
        destinationVC.menteeRequest = menteeRequest
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    

}
