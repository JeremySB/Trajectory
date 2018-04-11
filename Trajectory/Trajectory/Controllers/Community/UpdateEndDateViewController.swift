//
//  UpdateEndDateViewController.swift
//  Trajectory
//
//  Created by Andrew Vogel on 4/10/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import UIKit

class UpdateEndDateViewController: UIViewController {
    
    
    @IBOutlet weak var endDate: UIDatePicker!
    
    @IBOutlet weak var acceptBtn: UIButton!
    
    @IBOutlet weak var cancelBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let offSetDays = 90
        let defaultDate = Date().addingTimeInterval(TimeInterval(60 * 60 * 24 * offSetDays))
        endDate.minimumDate = Date()
        endDate.setDate(defaultDate, animated: true)
        endDate.setValue(UIColor.white, forKey: "textColor")

        acceptBtn.layer.borderColor = UIColor.lightGray.cgColor
        acceptBtn.layer.borderWidth = 2
        acceptBtn.layer.cornerRadius = 5
        cancelBtn.layer.borderColor = UIColor.lightGray.cgColor
        cancelBtn.layer.borderWidth = 2
        cancelBtn.layer.cornerRadius = 5
    }
    

   
    @IBAction func setDateAndAcceptBtn(_ sender: Any) {
        //TODO: update end date on backend
        print("WILL SAVE NEW END DATE")
    }
    
    
    @IBAction func cancelUpdate(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
