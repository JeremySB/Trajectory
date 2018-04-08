//
//  GoalsViewController.swift
//  Trajectory
//
//  Created by student on 1/25/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//
// Tutorial used to get the expanded cells up and running
// https://stackoverflow.com/questions/29049232/swift-how-to-use-dequeuereusablecellwithidentifier-with-two-cell-types-ident

import UIKit

class GoalsTableView: UITableView {
    var uid: String = ""
    var goals: [Goal] = [Goal]()
    
    struct CellData {
        static let ProgressHeight: CGFloat = 5
        static let ProgressRoundedCorners: CGFloat = 6
        static let DeadSpaceHeight: CGFloat = 50
    }
    
    var expandedSection: Int = -1
    
    lazy var goalsService: GoalsService = FirebaseGoalsService()
    
    func viewDidLoad() {
        self.dataSource = self
        goalsService.addGoalsListener(uid) { (receivedGoals, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let receivedGoals = receivedGoals else { return }
            self.goals = receivedGoals
            self.reloadData()
        }
        
        refreshControl = UIRefreshControl()
        
        refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl?.addTarget(self, action: #selector(Refresh(_:)), for: UIControlEvents.valueChanged)
        
    }
    
    func viewDidAppear() {
        reloadData()
    }
    
    @IBAction func Refresh(_ sender: Any?){
        reloadData()
        refreshControl?.endRefreshing()
    }
    
    func resetTableViewContentInset() {
        self.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    public func setExpandedSection(section: Int){
        var reload: [IndexPath] = [IndexPath]()
        
        if (expandedSection == section){
            if (expandedSection != -1){
                reload.append(IndexPath(row: 0, section: expandedSection))
            }
            expandedSection = -1
        } else{
            if (expandedSection != -1){
                reload.append(IndexPath(row:0, section: expandedSection))
            }
            expandedSection = section
            if (expandedSection != -1){
                reload.append(IndexPath(row: 0, section: expandedSection))
            }
        }
        self.reloadRows(at: reload, with: UITableViewRowAnimation.none)
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! EditGoalViewController
        destinationVC.goal = goals[expandedSection]
        expandedSection = -1
    }
    
}

extension GoalsTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.row == 1){
            return CellData.DeadSpaceHeight;
        }
        else if (indexPath.section == expandedSection){
            return 100
        }
        else {
            return 50
        }
     }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.deselectRow(at: indexPath, animated: true)
        let cell = self.cellForRow(at: indexPath) as? GoalsTableViewCell
        if (cell != nil){
            setExpandedSection(section: (cell?.cellNum)!)
        }
     }

    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        var cell: GoalsTableViewCell!
     
        if (indexPath.row == 1){
            return dequeueReusableCell(withIdentifier: "goalCellDeadspaceC", for: indexPath)
        }
        else{
            cell = dequeueReusableCell(withIdentifier: "goalCellExpandedC", for: indexPath) as! GoalsTableViewCell
        }
     
        //cell.parent = self
     
        cell.cellNum = indexPath.section
     
        cell.goal = goals[indexPath.section]
     
        cell.Title.text = goals[indexPath.section].title
     
     
        guard let curProgress = goals[indexPath.section].currentProgress else {
            cell.Progress.progress = 0
            return cell as! UITableViewCell
        }
        guard let toProgress = goals[indexPath.section].totalProgress else {
            cell.Progress.progress = 0
            return cell as! UITableViewCell
        }
        let prog = Float(curProgress) / Float(toProgress);
        cell.Progress.setProgress(prog, animated: cell.updated)
        cell.Progress.setup(ySize: CellData.ProgressHeight, cornerRadius: CellData.ProgressRoundedCorners)
     
        cell.ProgressLabel.text = String(curProgress) + "/" + String(toProgress)
     
        if (cell.updated) {
            cell.updated = false
        }
        return cell as! UITableViewCell
    }
    
     func numberOfSections(in tableView: UITableView) -> Int {
        return goals.count
     }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
     }
}
