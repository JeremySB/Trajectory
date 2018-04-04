//
//  MenteeRequestListTableViewController.swift
//  Trajectory
//
//  Created by Andrew Vogel on 1/25/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import UIKit
import Firebase

class MenteeRequestListTableViewController: UITableViewController {

    //An array of the user's mentee requests
    var menteeRequests = [MenteeRequest]()
    lazy var connectionService: ConnectionService = FirebaseConnectionService()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        connectionService.addOpenMenteeRequestsListener { (requests, error) in
            if let requests = requests {
                self.menteeRequests = requests
                self.tableView.reloadData()
            }
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        //Set background
        let imageView = UIImageView(image: UIImage(named: "TrajectoryBackground"))
        imageView.frame = self.tableView.frame
        self.tableView.backgroundView = imageView
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let rows = menteeRequests.count
        return rows
    }
    
    // Set status bar to white text
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func unwindToMenteeListAfterAccepting(segue:UIStoryboardSegue) { }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menteeListItem", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = menteeRequests[indexPath[1]].mentee.name
        cell.textLabel?.textColor = UIColor.white
        
        return cell
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        //https://stackoverflow.com/questions/26207846/pass-data-through-segue
        let indexPath = tableView.indexPathForSelectedRow
        let selectedMentee = menteeRequests[indexPath!.row]
        // Create an instance of destination view controller and pass the variable
        let destinationVC = segue.destination as! MenteeRequestDetailsViewController
        destinationVC.menteeRequest = selectedMentee
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }


}
