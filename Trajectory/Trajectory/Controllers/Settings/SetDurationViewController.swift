//
//  SetDurationViewController.swift
//  Trajectory
//
//  Created by Andrew Vogel on 1/27/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import UIKit

class SetDurationViewController: UIViewController {
    
    lazy var connService: ConnectionService = FirebaseConnectionService()
    lazy var imageService: ImageService = FirebaseImageService()

    
    var menteeRequest: MenteeRequest?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        nameLabel.text = menteeRequest?.mentee.name ?? "Error: No Name Found"
        if nameLabel.text == "" {nameLabel.text = "Error: No Name Found"}
        //organizationLabel.text = menteeRequest?.mentee.organization ?? "No Organizations Listed"
        if organizationLabel.text == "" {organizationLabel.text = "No Organizations Listed"}
        endDate.minimumDate = Date()
        endDate.setValue(UIColor.white, forKey: "textColor")
        
        if let uid = menteeRequest?.mentee.id {
            imageService.bindProfileImage(for: uid, to: self.userImage)
        }
        
        self.userImage.layer.cornerRadius = self.userImage.frame.size.width / 2;
        self.userImage.clipsToBounds = true;
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    
    @IBOutlet weak var endDate: UIDatePicker!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var organizationLabel: UILabel!
    
    // Set status bar to white text
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBOutlet weak var userImage: UIImageView!
    
    @IBAction func setDateandAccept(_ sender: Any) {
        if let menteeRequest = menteeRequest {
            connService.accept(menteeRequest: menteeRequest, until: endDate.date) { (error) in
                // no error checking for now
            }
            performSegue(withIdentifier: "unwindSeguetoSettings", sender: self)
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
