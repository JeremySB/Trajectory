//
//  GoalTableViewCell.swift
//  Trajectory
//
//  Created by student on 2/1/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import UIKit

class GoalTableViewCellClosed: UITableViewCell, GoalsTableViewCell{
    weak var goal: Goal!
    
    lazy var goalsService: GoalsService = FirebaseGoalsService()
    
    weak var parent: GoalsViewController!
    var cellNum: Int = -1
    @IBOutlet weak var Title: UILabel!
    @IBOutlet weak var Progress: UIProgressView!
    func Expand() {
        parent.setExpandedRow(row: cellNum)
    }
    /*
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }*/

}
