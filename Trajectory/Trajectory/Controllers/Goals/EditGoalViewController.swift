//
//  EditGoalViewController.swift
//  Trajectory
//
//  Created by student on 3/6/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import UIKit

class EditGoalViewController: UIViewController {
    weak var goal: Goal!
    
    lazy var goalsService: GoalsService = FirebaseGoalsService()
    
    @IBOutlet weak var Name: UITextField!
    
    @IBOutlet weak var RemainingProgress: UITextField!
    
    @IBOutlet weak var BySeparator: UISegmentedControl!
    @IBOutlet weak var EndDate: UIDatePicker!
    
    @IBOutlet weak var goalNameWarning: UILabel!
    @IBOutlet weak var progressAmountWarning: UILabel!
    
    @IBAction func Done(_ sender: Any) {
        guard let safeGoal = goal else{
            navigationController?.popViewController(animated: true)
            return
        }
        goal.title = Name.text ?? goal.title
        goal.currentProgress = Int(RemainingProgress.text ?? "") ?? goal.currentProgress
        goal.endDate = EndDate.date
        
        if(goal.title == ""){
            goalNameWarning.isHidden = false;
        }else{
            goalsService.editGoal(safeGoal, completion:  { (error) -> Void in
                if (error == nil){
                    debugPrint("No Error")
                }else{
                    debugPrint("Error")
                }
            })
            //self.dismiss(animated: true, completion: nil)
            navigationController?.popViewController(animated: true)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.title = "Edit"
        self.navigationItem.title = "Edit Goal"
        //self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: done, action: )
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(Done(_:)))
        //self.navigationItem
        Name.text = goal.title ?? ""
        EndDate.date = goal.endDate ?? Date()
        
        RemainingProgress.text = "\(goal.currentProgress ?? 0)"
        // Do any additional setup after loading the view.
        
        //Set end date minimum to today's date
        EndDate.minimumDate = Date()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func done(){
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
