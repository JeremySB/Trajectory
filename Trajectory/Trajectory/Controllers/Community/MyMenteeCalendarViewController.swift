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
    weak var _user: User!
    weak var user: User! {
        get{return self._user}
        set{ menteeName?.text = newValue.name; self._user = newValue; viewDidAppear(false)}
    }
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var menteeName: UILabel!
    @IBOutlet weak var organizations: UILabel!
    
    
    @IBAction func sendToCalendar(_ sender: Any) {
        if UIApplication.shared.canOpenURL(URL(string:"calshow://")!) {
            UIApplication.shared.open(URL(string:"calshow://")!, options: [:], completionHandler: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menteeName?.text = user?.name ?? ""
        if let uid = user?.id {
            imageService.bindProfileImage(for: uid, to: profileImage)
        }
        self.profileImage.layer.cornerRadius = self.profileImage.frame.size.width / 2;
        self.profileImage.clipsToBounds = true;
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        menteeName?.text = user?.name ?? ""
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
