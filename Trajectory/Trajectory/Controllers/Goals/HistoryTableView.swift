//
//  HistoryTableView.swift
//  Trajectory
//
//  Created by student on 4/10/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import UIKit

class HistoryTableView: GoalsTableView {
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goalsService.addGoalsListener { (receivedGoals, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let receivedGoals = receivedGoals else { return }
            self.goals = receivedGoals
            self.reloadData()
        }
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        reloadData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tmp = super.tableView(tableView, cellForRowAt: indexPath)
        if let cell = tmp as? GoalsTableViewCell {
            let formatter: DateFormatter = DateFormatter();
            formatter.dateFormat = "MM/dd/yyyy"
            guard let oldText = cell.Title.text else {
                return tmp
            }
            var startDateString = "???"
            if let startDate = goals[indexPath.section].startDate {
                startDateString = formatter.string(from: startDate)
            }
            var endDateString = "???"
            if let endDate = goals[indexPath.section].endDate {
                endDateString = formatter.string(from: endDate)
            }
            cell.Title.text = oldText + " " + startDateString + " - " + endDateString
            
            return cell as! UITableViewCell
        }
        return tmp
    }

}
