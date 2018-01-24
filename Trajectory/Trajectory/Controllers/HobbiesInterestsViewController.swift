//
//  HobbiesInterestsViewController.swift
//  Trajectory
//
//  Created by Andrew Vogel on 1/23/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import UIKit

class HobbiesInterestsViewController: UIViewController {

    //Array of user's profile information, which is based on information from previous screen
    var userData: [String] = ["empty"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.title = "Profile Setup"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var hobbies: UITextView!
    @IBOutlet weak var professionalInterests: UITextView!
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.destination is DenominationAndProfileGoalsViewController
        {
            let vc = segue.destination as? DenominationAndProfileGoalsViewController
            vc?.userData = userData
        }
    }
    

}
