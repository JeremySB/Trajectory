//
//  AddGoalViewController.swift
//  Trajectory
//
//  Created by Student on 1/30/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import UIKit
import Firebase
import CodableFirebase

class AddGoalViewController: UIViewController {
    
    var goalsService: GoalsService = FirebaseGoalsService()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func doneButton(_ sender: Any) {
        let goal = Goal()
        goal.title = "Example"
        
        goalsService.addGoal(goal) { (error) in
            if let error = error {
                let alert = UIAlertController(title: "Error", message: "Not logged in - goal not saved", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
                print(error)
                self.present(alert, animated: true, completion: nil)
            }
            else {
                print("Dismiss")
                self.dismiss(animated: true, completion: nil)
            }
        }
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
