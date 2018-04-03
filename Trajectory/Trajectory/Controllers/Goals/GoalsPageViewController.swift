//
//  GoalsPageViewController.swift
//  Trajectory
//
//  Created by student on 1/23/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//



import UIKit
import Foundation

class GoalsPageViewController: ScrollController {
    override func viewDidLoad() {
        addViewControllers(views: "History", "GoalsList", startIndex: 1)
        //var image = UIImage(named: "TrajectoryBackground")
        //self.view.backgroundColor = UIColor(patternImage: (UIImage(named: "TrajectoryBackground"))!)
            
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "TrajectoryBackground")
        self.view.insertSubview(backgroundImage, at: 0)
        super.viewDidLoad()
    }
}
