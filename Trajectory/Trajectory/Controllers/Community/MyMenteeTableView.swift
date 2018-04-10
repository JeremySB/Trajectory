//
//  MyMenteeTableView.swift
//  Trajectory
//
//  Created by student on 4/10/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import UIKit

class MyMenteeTableView: GoalsTableView {

    override func viewDidLoad() {
        super.viewDidLoad()
        goalsService.addActiveGoalsListener(uid) { (receivedGoals, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let receivedGoals = receivedGoals else { return }
            self.goals = receivedGoals
            self.reloadData()
        }
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
