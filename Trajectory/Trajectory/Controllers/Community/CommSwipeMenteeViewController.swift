//
//  CommSwipeMenteeViewController.swift
//  Trajectory
//
//  Created by student on 2/11/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import UIKit

class CommSwipeMenteeViewController: ScrollController {
    weak var user: User!
    
    required init?(coder: NSCoder){
        super.init(coder: coder)
        addViewControllers(views: "MyMenteeCalendar", "MyMenteeOptions")
        //addViewControllers(views: "FindOrgs")
    }
    override init(){
        super.init()
        addViewControllers(views: "MyMenteeCalendar", "MyMenteeOptions")
        //addViewControllers(views: "FindOrgs")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        for view in orderedViewControllers {
            var tmp = view as! UserChild
            tmp.user = self.user
        }
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "TrajectoryBackground")
        self.view.insertSubview(backgroundImage, at: 0)
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
