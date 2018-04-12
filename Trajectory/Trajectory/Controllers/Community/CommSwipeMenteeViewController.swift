//
//  CommSwipeMenteeViewController.swift
//  Trajectory
//
//  Created by student on 2/11/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import UIKit

class CommSwipeMenteeViewController: ScrollController {
    var user: User!
    
    override func viewDidLoad() {
        addViewControllers(views: "MyMenteeCalendar", "MyMenteeOptions")
        
        for view in orderedViewControllers {
            var tmp = view as! UserChild
            tmp.user = self.user
        }
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "TrajectoryBackground")
        self.view.insertSubview(backgroundImage, at: 0)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if var vc = segue.destination as? UserChild {
            vc.user = user
        }
    }
 

}
