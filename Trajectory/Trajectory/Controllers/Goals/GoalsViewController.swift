//
//  GoalsViewController.swift
//  Trajectory
//
//  Created by student on 1/25/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import UIKit

class GoalsViewController: UITableViewController {

    var goals: [Goal] = [Goal]()
    var row: Int = 0
    var section: Int = 0
    
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
        return 0//1//0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return goals.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // where it  breaks
        let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell", for: indexPath) as! GoalTableViewCell
        cell.goalTitle.text = goals[indexPath.row].title
        cell.goalProgress.progress = Float(goals[indexPath.row].currentProgress!) / Float(goals[indexPath.row].totalProgress!)
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        row = indexPath.row
        section = indexPath.section
        return indexPath
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
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
