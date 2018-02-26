//
//  MentorInfoViewController.swift
//  Trajectory
//
//  Created by student on 2/2/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import UIKit

class MentorInfoViewController: UIViewController {
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        /*user = User()
        user?.name = "John Smith"
        user?.organization = "Grove City"
        user?.hobbies = "Coding, computers, etc."
        user?.professionalInterests = "Computers, networking, etc."
        user?.denomination = "Castellism"
 */
        //Load mentor information
        MentorName.text = user?.name
        MentorOrg.text = user?.organization
        MentorHobbies.text = user?.hobbies
        MentorProfessionalInterests.text = user?.professionalInterests
        MentorDenomination.text = user?.denomination
        
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
        
        alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
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
