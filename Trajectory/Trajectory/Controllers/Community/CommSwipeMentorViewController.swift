//
//  CommSwipeMentorViewController.swift
//  Trajectory
//
//  Created by student on 2/11/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import UIKit

class CommSwipeMentorViewController: ScrollController {

    weak var user: User!
    
    required init?(coder: NSCoder){
        super.init(coder: coder)
        addViewControllers(views: "MyMentorCheckin", "MyMentorOptions")
        //addViewControllers(views: "FindOrgs")
    }
    override init(){
        super.init()
        addViewControllers(views: "MyMentorCheckin", "MyMentorOptions")
        //addViewControllers(views: "FindOrgs")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
