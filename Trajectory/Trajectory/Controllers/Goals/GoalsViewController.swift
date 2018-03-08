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

class GoalsViewController: UITableViewController {

    var goals: [Goal] = [Goal]()
    var row: Int = 0
    var section: Int = 0
    var expandedRow: Int = -1
    
    lazy var goalsService: GoalsService = FirebaseGoalsService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //var i: Int
//        for _ in 0..<5{
//            goals.append(Goal())
//        }
        
        goalsService.addGoalsListener { (receivedGoals, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let receivedGoals = receivedGoals else { return }
            self.goals = receivedGoals
            self.tableView.reloadData()
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1//0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return goals.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // where it  breaks
        var cell: GoalsTableViewCell!
        
        if (indexPath.row == expandedRow){
            cell = tableView.dequeueReusableCell(withIdentifier: "goalCellExpanded", for: indexPath) as! GoalsTableViewCell
        }else{
            cell = tableView.dequeueReusableCell(withIdentifier: "goalCellClosed", for: indexPath) as! GoalsTableViewCell
        }
        
        cell.parent = self
        cell.cellNum = indexPath.row
        cell.goal = goals[indexPath.row]
        cell.Title.text = goals[indexPath.row].title

        
        guard let curProgress = goals[indexPath.row].currentProgress else {
            cell.Progress.progress = 0
            return cell as! UITableViewCell
        }
        guard let toProgress = goals[indexPath.row].totalProgress else {
            cell.Progress.progress = 0
            return cell as! UITableViewCell
        }
        let prog = Float(curProgress) / Float(toProgress);
        cell.Progress.setProgress(prog, animated: true)
        return cell as! UITableViewCell
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        row = indexPath.row
        section = indexPath.section
        return indexPath
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }

    public func setExpandedRow(row: Int){
        var reload: [IndexPath] = [IndexPath]()
        
        if (expandedRow == row){
            if (expandedRow != -1){
                reload.append(IndexPath(row: expandedRow, section: 0))
            }
            expandedRow = -1
        } else{
            if (expandedRow != -1){
                reload.append(IndexPath(row: expandedRow, section: 0))
            }
            expandedRow = row
            if (expandedRow != -1){
                reload.append(IndexPath(row: expandedRow, section: 0))
            }
        }
        self.tableView.reloadRows(at: reload, with: UITableViewRowAnimation.none)
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.row == expandedRow){
            return 100
        }
        else {
            return 50
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! EditGoalViewController
        destinationVC.goal = goals[expandedRow]
    }
    /*func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }*/
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
