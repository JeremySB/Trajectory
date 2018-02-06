//
//  GoalTableViewCell.swift
//  Trajectory
//
//  Created by student on 2/1/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import UIKit

class GoalTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var goalTitle: UILabel!
    
    @IBOutlet weak var goalProgress: UIProgressView!
    
    @IBAction func expandGoalOptions(_ sender: Any) {
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
