//
//  MyOrganizationsTableViewController.swift
//  Trajectory
//
//  Created by Andrew Vogel on 1/25/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import UIKit
import MGSwipeTableCell

class MyOrganizationsTableViewController: UITableViewController {
    
    //An array of the user's organizations
    var userOrganizations = [Organization]()
    
    lazy var orgService: OrganizationService = FirebaseOrganizationService()
    lazy var userService: UserService = FirebaseUserService()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        
        //Set background
        let imageView = UIImageView(image: UIImage(named: "TrajectoryBackground"))
        imageView.frame = self.tableView.frame
        self.tableView.backgroundView = imageView

    }
    
    override func viewDidAppear(_ animated: Bool) {
        orgService.getCurrentOrganizations { (orgs, error) in
            if let orgs = orgs {
                self.userOrganizations = orgs
                self.tableView.reloadData()
            }
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        var rows = 1
        if section == 1 {
            rows = userOrganizations.count
        }
        return rows
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //If in the first section...
        if(indexPath == [0, 0]) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "addOrganizationCell", for: indexPath)
            // Configure the cell...
            cell.textLabel?.text = "Add Organization"
            cell.textLabel?.textColor = UIColor.white
            return cell
        }
        //If in the second section...
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "organizationCell", for: indexPath)
            cell.textLabel?.text = userOrganizations[indexPath[1]].name
            cell.textLabel?.textColor = UIColor.white
            //configure right buttons
            /*cell.rightButtons = [MGSwipeButton(title: "Delete", backgroundColor: .red),
                                 MGSwipeButton(title: "More",backgroundColor: .lightGray)]
            cell.rightSwipeSettings.transition = .rotate3D*/
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //TODO finish implemenation of saving change in user's organizations on the backend
            orgService.leaveOrganization(userOrganizations[indexPath.row].id ?? "", completion: { (error) in
                if error == nil {
                    self.userOrganizations.remove(at: indexPath.row)
                    self.tableView.reloadData()
                }
            })
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(section == 0) {
            return "Add Organization"
        } else {
            return "Joined Organizations"
        }
    }

    // Set status bar to white text
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
