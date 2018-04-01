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
    weak var _user: User!
    weak var user: User! {
        get{return self._user}
        set{ mentorName?.text = newValue.name; self._user = newValue; viewDidAppear(false)}
    }
    
    //Variable that holds current check-in
    var currentCheckIn : String? = nil

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var mentorName: UILabel!
    @IBOutlet weak var organizations: UILabel!
    
    @IBOutlet weak var doingWellButton: UIButton!
    @IBOutlet weak var alrightButton: UIButton!
    @IBOutlet weak var notGoodButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mentorName.text = user?.name ?? ""
        if let uid = user?.id {
            imageService.bindProfileImage(for: uid, to: profileImage)
        }
        // Do any additional setup after loading the view.
        getAndSetCheckInButtons()
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
            doingWellButton.setTitle("Check-In Confirmed", for: .normal)
            //TODO: figure out color //doingWellButton.backgroundColor = UIColor.green
            
            //Enable/disable buttons appropriately
            doingWellButton.isEnabled = false
            alrightButton.isEnabled = true
            notGoodButton.isEnabled = true
            
            //TODO: save status to backend with a date stamp and send notification to mentor
            let dateStamp = Date()
            print(dateStamp)
            
        }
    }
    
    @IBAction func alrightCheckIn(_ sender: Any) {
        if currentCheckIn != "alright" {
            alrightButton.setTitle("Check-In Confirmed", for: .normal)
            //TODO: figure out color //alrightButton.backgroundColor = UIColor.yellow
            
            //Enable/disable buttons appropriately
            doingWellButton.isEnabled = true
            alrightButton.isEnabled = false
            notGoodButton.isEnabled = true
            
            //TODO: save status to backend with a date stamp and send notification to mentor
            let dateStamp = Date()
            print(dateStamp)
            
        }
    }
    
    @IBAction func notGoodCheckIn(_ sender: Any) {
        if currentCheckIn != "notGood" {
            notGoodButton.setTitle("Check-In Confirmed", for: .normal)
            //TODO: figure out color //notGoodButton.backgroundColor = UIColor.red
            
            //Enable/disable buttons appropriately
            doingWellButton.isEnabled = true
            alrightButton.isEnabled = true
            notGoodButton.isEnabled = false
            
            //TODO: save status to backend with a date stamp and send notification to mentor
            let dateStamp = Date()
            print(dateStamp)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mentorName.text = user?.name ?? ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
