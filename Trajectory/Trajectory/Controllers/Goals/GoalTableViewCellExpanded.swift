//
//  GoalTableViewCellExpanded.swift
//  Trajectory
//
//  Created by student on 2/23/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import UIKit

class GoalTableViewCellExpanded: UITableViewCell, GoalsTableViewCell {
    weak var goal: Goal!
    
    lazy var goalsService: GoalsService = FirebaseGoalsService()

    
    public weak var parent: GoalsViewController!
    var cellNum: Int = -1
    @IBOutlet weak var Title: UILabel!
    @IBOutlet weak var Progress: UIProgressView!
    
    @IBOutlet weak var AdjustAmount: UITextField!
    @IBAction func Expand(_ sender: Any) {
        parent.setExpandedRow(row: cellNum)
    }
    
    
    @IBAction func RemoveGoal(_ sender: Any) {
        self.parent?.setExpandedRow(row: -1)
        goalsService.removeGoal(goal) { (error) in
            if (error == nil){
            }
        }
    }
    
    @IBAction func Plus(_ sender: Any) {
        goal.currentProgress = min((goal.currentProgress ?? 0) + (Int(AdjustAmount.text ?? "") ?? 0), goal.totalProgress ?? 0)
        goalsService.editGoal(goal, completion: nil)
    }
    @IBAction func Minus(_ sender: Any) {
        goal.currentProgress = max((goal.currentProgress ?? 0) - (Int(AdjustAmount.text ?? "") ?? 0), 0)
        goalsService.editGoal(goal, completion: nil)
    }
    override func prepareForReuse() {
        cellNum = -1
        /*Title = nil
        Progress = nil*/
        parent = nil
        goal = nil
    }
    /*
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    */
}

