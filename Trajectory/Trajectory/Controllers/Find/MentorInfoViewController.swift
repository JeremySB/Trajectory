//
//  MentorInfoViewController.swift
//  Trajectory
//
//  Created by student on 2/2/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import UIKit

class MentorInfoViewController: UIViewController {
    
    lazy var connectionService: ConnectionService = FirebaseConnectionService()
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Load mentor information
        MentorName.text = user?.name ?? "No Name"
        MentorOrg.text = user?.organization ?? "No Organization"
        MentorHobbies.text = user?.hobbies ?? "No Hobbies"
        MentorProfessionalInterests.text = user?.professionalInterests ?? "No Professional Interests"
        MentorDenomination.text = user?.denomination ?? "No Denomination"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var MentorImage: UIImageView!
    @IBOutlet weak var MentorName: UILabel!
    @IBOutlet weak var MentorOrg: UILabel!
    @IBOutlet weak var MentorHobbies: UITextView!
    @IBOutlet weak var MentorProfessionalInterests: UITextView!
    @IBOutlet weak var MentorDenomination: UILabel!
    
    
    @IBAction func ContactMentorButton(_ sender: Any) {
        //https://learnappmaking.com/uialertcontroller-alerts-swift-how-to/
        let alert = UIAlertController(title: "Please confirm that you want to send this mentee request", message: "", preferredStyle: .actionSheet)
        
        //https://stackoverflow.com/questions/24190277/writing-handler-for-uialertaction
        alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: sendMenteeRequest))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    func sendMenteeRequest(alert: UIAlertAction!) {
        guard let uid = user?.id else { return }
        
        //Send mentee request to specified mentor
        connectionService.sendMentorRequest(to: uid) { (error) in
            if let _ = error {
                
            } else {
                //Navigate back to search screen (dismiss mentor information screen)
                //https://stackoverflow.com/questions/28760541/programmatically-go-back-to-previous-viewcontroller-in-swift
                self.navigationController?.popViewController(animated: true)
            }
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
