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

    var goals: [Goal] = [Goal]() {
        didSet {
            //Hide initial login message if applicable
            if goals.count != 0 {
                initialLoginMessage.isHidden = true
                resetTableViewContentInset()
            } else if updated == false {
                updateTableViewContentInset()
                print("HIT")
            }
        }
    }
    
    struct CellData {
        static let ProgressHeight: CGFloat = 5
        static let ProgressRoundedCorners: CGFloat = 6
        static let DeadSpaceHeight: CGFloat = 50
    }
    
    var row: Int = 0
    var section: Int = 0
    //var section: Int = 0
    var expandedRow: Int = -1
    var expandedSection: Int = -1
    var updated: Bool = false
    var firstTimeToUpdate: Bool = true
    
    lazy var goalsService: GoalsService = FirebaseGoalsService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        goalsService.addGoalsListener { (receivedGoals, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let receivedGoals = receivedGoals else { return }
            self.goals = receivedGoals
            self.tableView.reloadData()
            if self.goals.count > 0 {
                self.resetTableViewContentInset()
            } else {
                self.initialLoginMessage.isHidden = false
            }
        }
        
        // https://stackoverflow.com/questions/25845855/transparent-navigation-bar-ios
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        //self.navigationController?.navigationBar.isTranslucent = true
        //self.navigationController?.view.backgroundColor = .clear
        
        refreshControl = UIRefreshControl()
        
        refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl?.addTarget(self, action: #selector(Refresh(_:)), for: UIControlEvents.valueChanged)
        // Do any additional setup after loading the view.

        if firstTimeToUpdate == true {
            updateTableViewContentInset()
            firstTimeToUpdate = false
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    @IBOutlet weak var initialLoginMessage: UILabel!
    
    @IBAction func Refresh(_ sender: Any?){
        tableView.reloadData()
        refreshControl?.endRefreshing()
    }
    
    func updateTableViewContentInset() {
        let viewHeight: CGFloat = view.frame.size.height
        let tableViewContentHeight: CGFloat = tableView.contentSize.height
        let marginHeight: CGFloat = (viewHeight - tableViewContentHeight) / 2.0
        self.tableView.contentInset = UIEdgeInsets(top: marginHeight - 100, left: 0, bottom:  -marginHeight + 100, right: 0)
        updated = true
    }
    
    func resetTableViewContentInset() {
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        updated = false
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return goals.count//1//0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2//1//goals.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // where it  breaks
        var cell: GoalsTableViewCell!
        
        //if (indexPath.row == expandedRow){
        if (indexPath.row == 1){
            return tableView.dequeueReusableCell(withIdentifier: "goalCellDeadspace", for: indexPath)
        }/*else if (indexPath.section == expandedSection){
            cell = tableView.dequeueReusableCell(withIdentifier: "goalCellExpanded", for: indexPath) as! GoalsTableViewCell
        }else{
            cell = tableView.dequeueReusableCell(withIdentifier: "goalCellClosed", for: indexPath) as! GoalsTableViewCell
        }*/
        else{
            cell = tableView.dequeueReusableCell(withIdentifier: "goalCellExpanded", for: indexPath) as! GoalsTableViewCell

        }
        
        cell.parent = self
        //cell.cellNum = indexPath.row
        cell.cellNum = indexPath.section
        //cell.goal = goals[indexPath.row]
        cell.goal = goals[indexPath.section]
        //cell.Title.text = goals[indexPath.row].title
        cell.Title.text = goals[indexPath.section].title

        
        //guard let curProgress = goals[indexPath.row].currentProgress else {
        guard let curProgress = goals[indexPath.section].currentProgress else {
            cell.Progress.progress = 0
            return cell as! UITableViewCell
        }
        //guard let toProgress = goals[indexPath.row].totalProgress else {
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
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        row = indexPath.row
        section = indexPath.section
        return indexPath
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        /*if let cell = self.tableView.cellForRow(at: indexPath) as? GoalTableViewCellClosed {
            //cell.Expand();
            setExpandedRow(row: cell.cellNum)
        } else if let cell = self.tableView.cellForRow(at: indexPath) as? GoalTableViewCellExpanded {
            //cell.Expand();
            setExpandedRow(row: cell.cellNum)
        }*/
        let cell = self.tableView.cellForRow(at: indexPath) as? GoalsTableViewCell
        if (cell != nil){
            setExpandedRow(row: (cell?.cellNum)!)
        }
    }

    public func setExpandedRow(row: Int){
        var reload: [IndexPath] = [IndexPath]()
        
        if (expandedSection == section){//expandedRow == row){
            //if (expandedRow != -1){
            if (expandedSection != -1){
                //reload.append(IndexPath(row: expandedRow, section: 0))
            reload.append(IndexPath(row: 0, section: expandedSection))
            }
            //expandedRow = -1
            expandedSection = -1
        } else{
            //if (expandedRow != -1){
            if (expandedSection != -1){
                //reload.append(IndexPath(row: expandedRow, section: 0))
                reload.append(IndexPath(row:0, section: expandedSection))
            }
            //expandedRow = row
            expandedSection = row
            //if (expandedRow != -1){
            if (expandedSection != -1){
                //reload.append(IndexPath(row: expandedRow, section: 0))
                reload.append(IndexPath(row: 0, section: expandedSection))
            }
        }
        self.tableView.reloadRows(at: reload, with: UITableViewRowAnimation.none)
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.row == 1){
            return CellData.DeadSpaceHeight;
        }
        else if (indexPath.section == expandedSection){
        //if (indexPath.row == expandedRow){
            return 100
        }
        else {
            return 50
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! EditGoalViewController
        destinationVC.goal = goals[expandedSection]//expandedRow]
        //expandedRow = -1
        expandedSection = -1
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
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
