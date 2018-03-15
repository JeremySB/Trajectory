//
//  MyMenteeCalendarViewController.swift
//  Trajectory
//
//  Created by student on 2/11/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import UIKit

class MyMenteeCalendarViewController: UIViewController, UserChild {
    weak var _user: User!
    weak var user: User! {
        get{return self._user}
        set{ menteeName?.text = newValue.name; self._user = newValue; viewDidAppear(false)}
    }
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var menteeName: UILabel!
    @IBOutlet weak var organizations: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        menteeName?.text = user?.name ?? ""
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
