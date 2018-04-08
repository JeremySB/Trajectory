//
//  MyMenteeCalendarViewController.swift
//  Trajectory
//
//  Created by student on 2/11/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import UIKit

class MyMenteeCalendarViewController: UIViewController, UserChild {
    
    lazy var imageService: ImageService = FirebaseImageService()
    lazy var connectionService: ConnectionService = FirebaseConnectionService()
    lazy var authService: AuthenticationService = FirebaseAuthenticationService()
    weak var _user: User!
    weak var user: User! {
        get{return self._user}
        set{
            menteeName?.text = newValue.name
            self._user = newValue
            if let uid = user?.id {
                imageService.bindProfileImage(for: uid, to: profileImage)
            }
            viewDidAppear(false)
        }
    }
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var menteeName: UILabel!
    @IBOutlet weak var organizations: UILabel!
    @IBOutlet weak var lastCheckin: UILabel!
    @IBOutlet weak var goalsList: GoalsTableView!
    
    
    @IBAction func sendToCalendar(_ sender: Any) {
        if UIApplication.shared.canOpenURL(URL(string:"calshow://")!) {
            UIApplication.shared.open(URL(string:"calshow://")!, options: [:], completionHandler: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lastCheckin.text = ""
        goalsList.uid = _user?.id ?? ""
        goalsList.viewDidLoad()
        menteeName?.text = user?.name ?? ""

        self.profileImage.layer.cornerRadius = self.profileImage.frame.size.width / 2;
        self.profileImage.clipsToBounds = true;
        // Do any additional setup after loading the view.
        menteeName.textColor = UIColor.white
        organizations.textColor = UIColor.white
        
        if let ourUid = authService.currentUID, let theirUid = user?.id {
            connectionService.addLatestCheckinListener(from: theirUid, to: ourUid) { (checkin, error) in
                guard let checkin = checkin, let status = checkin.status, let date = checkin.dateCreated else { return }
                var msg = "Last Check-in: "
                switch(status) {
                case .good:
                    msg += "Doing Well"
                case .fine:
                    msg += "Alright"
                case .poor:
                    msg += "Not Good"
                }
                let cal = Calendar(identifier: .gregorian)
                msg += " (\(cal.component(.month, from: date))/\(cal.component(.day, from: date)))"
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        menteeName?.text = user?.name ?? ""
        goalsList.viewDidAppear()
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
