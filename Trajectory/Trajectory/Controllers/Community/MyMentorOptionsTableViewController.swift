//
//  MyMentorOptionsTableViewController.swift
//  Trajectory
//
//  Created by student on 3/15/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import UIKit

class MyMentorOptionsTableViewController: UITableViewController, UserChild {
    weak var user: User!
    
    lazy var imageService: ImageService = FirebaseImageService()
    lazy var connectionService: ConnectionService = FirebaseConnectionService()
    lazy var authService: AuthenticationService = FirebaseAuthenticationService()
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var mentorName: UILabel!
    @IBOutlet weak var organizations: UILabel!
    
    func writeUserData(){
        mentorName?.text = user?.name ?? ""
        organizations?.text = user?.lastOrganizationName ?? "No Organization"
        if let uid = user.id {
            imageService.bindProfileImage(for: uid, to: self.profileImage)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        writeUserData()
        
        self.profileImage.layer.cornerRadius = self.profileImage.frame.size.width / 2;
        self.profileImage.clipsToBounds = true;
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        writeUserData()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 30))
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if(section == 0){
            return 1
        }else{
            return 3
        }
    }
    
    @IBAction func MembershipCancellation(_ sender: Any) {
        //https://learnappmaking.com/uialertcontroller-alerts-swift-how-to/
        let alert = UIAlertController(title: "Please confirm that you want to cancel this mentorship", message: "", preferredStyle: .actionSheet)
        
        //https://stackoverflow.com/questions/24190277/writing-handler-for-uialertaction
        alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: cancelMentorship))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    func cancelMentorship(alert: UIAlertAction!) {
        self.navigationController?.popViewController(animated: true)
        guard let uid = authService.currentUID, let mentorId = user.id else { return }
        connectionService.getConnectionBetween(mentee: uid, mentor: mentorId) { (conn, error) in
            if let conn = conn {
                conn.mentorStatus = .ended
                self.connectionService.saveConnection(conn, completion: { (error) in
                    
                })
            }
        }
    }
    
    //Opens message app and creates a new message when user taps this option
    @IBAction func contactMentor(_ sender: Any) {
        if UIApplication.shared.canOpenURL(URL(string:"sms:")!) {
            UIApplication.shared.open(URL(string:"sms:")!, options: [:], completionHandler: nil)
        }
    }
    
    
    //Sends notification to mentor that mentee is requesting a new end date
    @IBAction func requestNewEndDate(_ sender: Any) {
        print("WILL REQUEST NEW END DATE")
    }
    
    
    @IBAction func sendToCalendar(_ sender: Any) {
        if UIApplication.shared.canOpenURL(URL(string:"calshow://")!) {
            UIApplication.shared.open(URL(string:"calshow://")!, options: [:], completionHandler: nil)
        }
    }
}
