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
    
    lazy var goalsService: GoalsService = FirebaseGoalsService()

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var endDatePicker: UIDatePicker!
    @IBOutlet weak var progressAmount: UITextField!
    @IBOutlet weak var segmentedControlPeriod: UISegmentedControl!
    @IBOutlet weak var progressAmountWarning: UILabel!
    @IBOutlet weak var goalNameWarning: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //Set end date minimum to today's date
        endDatePicker.minimumDate = Date()
        endDatePicker.setValue(UIColor.white, forKey: "textColor")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    @IBAction func doneButton(_ sender: Any) {
        goalNameWarning.isHidden = true;
        progressAmountWarning.isHidden = true;
        
        let goal = Goal()
        goal.title = nameField.text
        goal.endDate = endDatePicker.date
        goal.totalProgress = Int(progressAmount.text ?? "")
        // goal.progressPeriod = segmentedControlPeriod.
        
        if(goal.title == "" || goal.totalProgress == nil){
            if(goal.title == ""){
                goalNameWarning.isHidden = false;
            }
            if(goal.totalProgress == nil){
                progressAmountWarning.isHidden = false;
            }
        }else{
            goalsService.addGoal(goal) { (error) in
                if let error = error {
                    let alert = UIAlertController(title: "Error", message: "Not logged in - goal not saved", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
                    print(error)
                    self.present(alert, animated: true, completion: nil)
                }
                else {
                    self.dismiss(animated: true, completion: nil)
                }
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
