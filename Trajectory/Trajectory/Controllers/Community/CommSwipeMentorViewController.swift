//
//  CommSwipeMentorViewController.swift
//  Trajectory
//
//  Created by student on 2/11/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import UIKit

protocol UserChild {
    var user: User! {get set}
}

class CommSwipeMentorViewController: ScrollController {

    weak var user: User!
    
    override func viewDidLoad() {
        addViewControllers(views: "MyMentorCheckin", "MyMentorOptions")
        
        for view in orderedViewControllers {
            var tmp = view as! UserChild
            tmp.user = self.user
        }
        
        super.viewDidLoad()
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "TrajectoryBackground")
        self.view.insertSubview(backgroundImage, at: 0)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var vc = segue.destination as! UserChild
        vc.user = user
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
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
