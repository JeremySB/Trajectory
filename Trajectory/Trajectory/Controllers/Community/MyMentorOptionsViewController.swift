//
//  MyMentorOptionsViewController.swift
//  Trajectory
//
//  Created by student on 2/11/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import UIKit

class MyMentorOptionsViewController: UIViewController, UserChild {
    
    weak var user: User!

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var mentorName: UILabel!
    @IBOutlet weak var organizations: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.profileImage.layer.cornerRadius = self.profileImage.frame.size.width / 2;
        self.profileImage.clipsToBounds = true;
        
        mentorName.text = user?.name ?? "Error: No Name"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func CancelMentorshipConfirmation(_ sender: Any) {
        //https://learnappmaking.com/uialertcontroller-alerts-swift-how-to/
        let alert = UIAlertController(title: "Please confirm that you want to cancel this mentorship", message: "", preferredStyle: .actionSheet)
        
        //https://stackoverflow.com/questions/24190277/writing-handler-for-uialertaction
        alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: cancelMentorship))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    func cancelMentorship(alert: UIAlertAction!) {
        //TODO - Cancel mentorship on backend
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
