//
//  CommViewController.swift
//  Trajectory
//
//  Created by student on 2/11/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import UIKit

class CommViewController: ScrollController {
    
    required init?(coder: NSCoder){
        super.init(coder: coder)
        addViewControllers(views: "CommMentor", "CommMentee")
        //addViewControllers(views: "FindOrgs")
    }
    override init(){
        super.init()
        addViewControllers(views: "CommMentor", "CommMentee")
        //addViewControllers(views: "FindOrgs")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "TrajectoryBackground")
        self.view.insertSubview(backgroundImage, at: 0)
        // Do any additional setup after loading the view.
    }
    

}
