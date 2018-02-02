//
//  HobbiesInterestsViewController.swift
//  Trajectory
//
//  Created by Andrew Vogel on 1/23/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import UIKit
import Firebase

class HobbiesInterestsViewController: UIViewController {
    
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

    @IBAction func didTapNext(_ sender: Any) {
        let db = Firestore.firestore()
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        db.collection("users").document(uid)
            .setData(["hobbies" : hobbies.text,
                      "professionallyInterests" : professionalInterests.text],
                     options: SetOptions.merge()) { (error) in
            if let error = error {
                print(error.localizedDescription)
            }
            else {
                self.performSegue(withIdentifier: "hobbiesAndInterestsToDenominationAndGoals", sender: self)
            }
        }
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
}
