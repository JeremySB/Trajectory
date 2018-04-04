//
//  AddGoalViewController.swift
//  Trajectory
//
//  Created by Student on 1/30/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import UIKit
import Firebase
import CodableFirebase

class AddGoalViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    lazy var goalsService: GoalsService = FirebaseGoalsService()

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var endDatePicker: UIDatePicker!
    @IBOutlet weak var progressAmount: UITextField!
    @IBOutlet weak var progressAmountWarning: UILabel!
    @IBOutlet weak var goalNameWarning: UILabel!
    @IBOutlet weak var recurancePicker: UIPickerView!
    var pickerData: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //Set end date minimum to today's date
        endDatePicker.minimumDate = Date()
        endDatePicker.setValue(UIColor.white, forKey: "textColor")
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "TrajectoryBackground")
        self.view.insertSubview(backgroundImage, at: 0)
        
        pickerData = ["Total", "Daily", "Weekly", "Monthly"]
        
        var placeHolder = NSMutableAttributedString()
        let Name  = "Goal Name"
        
        // Set the Font
        placeHolder = NSMutableAttributedString(string:Name, attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.regular)])
        
        // Set the color
        placeHolder.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.lightGray, range:NSRange(location:0,length:Name.count))
        
        // Add attribute
        nameField.attributedPlaceholder = placeHolder
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    @IBAction func doneButton(_ sender: Any) {
        goalNameWarning.isHidden = true;
        progressAmountWarning.isHidden = true;
        
        let goal = Goal()
        goal.title = nameField.text
        goal.endDate = endDatePicker.date
        goal.totalProgress = Int(progressAmount.text ?? "")
        // goal.progressPeriod = segmentedControlPeriod.
        
        if(goal.title == "" || goal.totalProgress == nil){
            if(goal.title == ""){
                goalNameWarning.isHidden = false;
            }
            if(goal.totalProgress == nil){
                progressAmountWarning.isHidden = false;
            }
        }else{
            goalsService.addGoal(goal) { (error) in
                if let error = error {
                    let alert = UIAlertController(title: "Error", message: "Not logged in - goal not saved", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
                    print(error)
                    self.present(alert, animated: true, completion: nil)
                }
                else {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // Set status bar to white text
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel: UILabel? = (view as? UILabel)
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.regular)
            pickerLabel?.textAlignment = .center
        }
        pickerLabel?.text = pickerData[row]
        pickerLabel?.textColor = UIColor.white
        
        return pickerLabel!
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
