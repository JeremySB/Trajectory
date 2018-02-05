//
//  SetDurationViewController.swift
//  Trajectory
//
//  Created by Andrew Vogel on 1/27/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import UIKit

class SetDurationViewController: UIViewController {
    
    var menteeRequest: MenteeRequest?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        nameLabel.text = menteeRequest?.mentee.name
        organizationLabel.text = menteeRequest?.mentee.organization
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBOutlet weak var endDate: UIDatePicker!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var organizationLabel: UILabel!
    
    
    @IBOutlet weak var userImage: UIImageView!
    
    @IBAction func setDateandAccept(_ sender: Any) {
        print(endDate.date)
        performSegue(withIdentifier: "unwindSeguetoSettings", sender: self)
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
