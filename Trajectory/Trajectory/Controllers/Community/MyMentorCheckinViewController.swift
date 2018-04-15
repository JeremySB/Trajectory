//
//  MyMentorCheckinViewController.swift
//  Trajectory
//
//  Created by student on 2/11/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import UIKit

class MyMentorCheckinViewController: UIViewController, UserChild {
    lazy var imageService: ImageService = FirebaseImageService()
    lazy var connService: ConnectionService = FirebaseConnectionService()
    weak var user: User!
    
    //Variable that holds current check-in
    var currentCheckIn : String? = nil
    
    //Variable used for haptic feedback
    let impact = UIImpactFeedbackGenerator()

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var mentorName: UILabel!
    @IBOutlet weak var organizations: UILabel!
    
    @IBOutlet weak var doingWellButton: UIButton!
    @IBOutlet weak var alrightButton: UIButton!
    @IBOutlet weak var notGoodButton: UIButton!

    func writeUserData(){
        mentorName.text = user?.name ?? ""
        organizations.text = user?.lastOrganizationName ?? "No Organization"
        
        if let uid = user?.id {
            imageService.bindProfileImage(for: uid, to: profileImage)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        writeUserData()
        
        self.profileImage.layer.cornerRadius = self.profileImage.frame.size.width / 2;
        self.profileImage.clipsToBounds = true;
        // Do any additional setup after loading the view.
        getAndSetCheckInButtons()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        writeUserData()
    }
    
    @IBAction func sendToCalendar(_ sender: Any) {
        if UIApplication.shared.canOpenURL(URL(string:"calshow://")!) {
            UIApplication.shared.open(URL(string:"calshow://")!, options: [:], completionHandler: nil)
        }
    }
    
    //Function that gets latest check-in and enables current check-in if applicable
    func getAndSetCheckInButtons() {
        //TODO: pull latest check-in from backend and set it as current check-in if date stamp matches today's date
        
        //Set check-in buttons corresponding to value of current check-in
        if currentCheckIn == "doingWell" {
            doingWellButton.setTitle("Check-In Confirmed", for: .normal)
            //TODO: figure out color //doingWellButton.backgroundColor = UIColor.green
            doingWellButton.isEnabled = false
        } else if currentCheckIn == "alright" {
            alrightButton.setTitle("Check-In Confirmed", for: .normal)
            //TODO: figure out color //alrightButton.backgroundColor = UIColor.yellow
            alrightButton.isEnabled = false
        } else if currentCheckIn == "notGood" {
            notGoodButton.setTitle("Check-In Confirmed", for: .normal)
            //TODO: figure out color //notGoodButton.backgroundColor = UIColor.red
            notGoodButton.isEnabled = false
        }
    }

    @IBAction func doingWellCheckIn(_ sender: Any) {
        if currentCheckIn != "doingWell" {
            //Set titles
            doingWellButton.setTitle("Check-In Confirmed", for: .normal)
            alrightButton.setTitle("Alright", for: .normal)
            notGoodButton.setTitle("Not Good", for: .normal)

            //TODO: set colors
            doingWellButton.backgroundColor = UIColor.green
            alrightButton.backgroundColor = UIColor.yellow
            notGoodButton.backgroundColor = UIColor.red
            
            //Enable/disable buttons appropriately
            doingWellButton.isEnabled = false
            alrightButton.isEnabled = true
            notGoodButton.isEnabled = true
            
            
            currentCheckIn = "doingWell"
            connService.addCheckin(Checkin(status: .good), with: user) { (error) in
            }
            
            //Give haptic feedback
            impact.impactOccurred()
            
            //TODO: send notification to mentor

        }
    }
    
    @IBAction func alrightCheckIn(_ sender: Any) {
        if currentCheckIn != "alright" {
            //Set titles
            doingWellButton.setTitle("Doing Well", for: .normal)
            alrightButton.setTitle("Check-In Confirmed", for: .normal)
            notGoodButton.setTitle("Not Good", for: .normal)

            //TODO: Set colors
            doingWellButton.backgroundColor = UIColor.green
            alrightButton.backgroundColor = UIColor.yellow
            notGoodButton.backgroundColor = UIColor.red
            
            //Enable/disable buttons appropriately
            doingWellButton.isEnabled = true
            alrightButton.isEnabled = false
            notGoodButton.isEnabled = true
            
            //TODO: save status to backend with a date stamp
            currentCheckIn = "alright"
            connService.addCheckin(Checkin(status: .fine), with: user) { (error) in
            }
            
            //Give haptic feedback
            impact.impactOccurred()
            
            //TODO: send notification to mentor

        }
    }
    
    @IBAction func notGoodCheckIn(_ sender: Any) {
        if currentCheckIn != "notGood" {
            //Set titles
            doingWellButton.setTitle("Doing Well", for: .normal)
            alrightButton.setTitle("Alright", for: .normal)
            notGoodButton.setTitle("Check-In Confirmed", for: .normal)
            
            //TODO: Set colors
            doingWellButton.backgroundColor = UIColor.green
            alrightButton.backgroundColor = UIColor.yellow
            notGoodButton.backgroundColor = UIColor.red
            
            //Enable/disable buttons appropriately
            doingWellButton.isEnabled = true
            alrightButton.isEnabled = true
            notGoodButton.isEnabled = false
            
            //TODO: save status to backend with a date stamp
            currentCheckIn = "notGood"
            connService.addCheckin(Checkin(status: .poor), with: user) { (error) in
            }
            
            //Give haptic feedback
            impact.impactOccurred()
            
            //TODO: send notification to mentor
            
        }
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
