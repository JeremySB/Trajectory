//
//  EditGoalViewController.swift
//  Trajectory
//
//  Created by student on 3/6/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import UIKit

class EditGoalViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    var goal: Goal!
    
    lazy var goalsService: GoalsService = FirebaseGoalsService()
    
    @IBOutlet weak var Name: UITextField!
    @IBOutlet weak var RemainingProgress: UITextField!
    
    @IBOutlet weak var BySeparator: UISegmentedControl!
    @IBOutlet weak var EndDate: UIDatePicker!
    
    @IBOutlet weak var goalNameWarning: UILabel!
    @IBOutlet weak var progressAmountWarning: UILabel!
    
    @IBOutlet weak var recurancePicker: UIPickerView!
    var pickerData: [String] = [String]()
    
    
    /*@IBAction func Cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }*/
    
    @IBAction func Done(_ sender: Any) {
        guard let safeGoal = goal else {
            navigationController?.popViewController(animated: true)
            return
        }
        goal.title = Name.text ?? goal.title
        goal.currentProgress = Int(RemainingProgress.text ?? "") ?? goal.currentProgress
        goal.endDate = EndDate.date
        
        if(goal.title == ""){
            goalNameWarning.isHidden = false;
        }else{
            goalsService.editGoal(safeGoal, completion:  { (error) -> Void in
                if (error == nil){
                    debugPrint("No Error")
                }else{
                    debugPrint("Error")
                }
            })
            //self.dismiss(animated: true, completion: nil)
            navigationController?.popViewController(animated: true)
        }
    }
    
    
    
    // Set status bar to white text
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Edit Goal"
        
        var placeHolder = NSMutableAttributedString()
        let goalName  = "Goal Name"
        
        // Set the Font
        placeHolder = NSMutableAttributedString(string:goalName, attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.regular)])
        
        // Set the color
        placeHolder.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.lightGray, range:NSRange(location:0,length:goalName.count))
        
        // Add attribute
        Name.attributedPlaceholder = placeHolder
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(Done(_:)))
        
        Name.text = goal.title ?? ""
        EndDate.date = goal.endDate ?? Date()
        
        RemainingProgress.text = "\(goal.currentProgress ?? 0)"
        // Do any additional setup after loading the view.
        
        pickerData = ["Total", "Daily", "Weekly", "Monthly"]
        
        //Set end date minimum to today's date
        EndDate.minimumDate = Date()
        EndDate.setValue(UIColor.white, forKey: "textColor")
        
        
        Name.attributedPlaceholder = NSAttributedString(string:"Goal Name", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "TrajectoryBackground")
        self.view.insertSubview(backgroundImage, at: 0)
        
        let nameFieldborder = CALayer()
        let nameFieldwidth = CGFloat(2.0)
        nameFieldborder.borderColor = UIColor.darkGray.cgColor
        nameFieldborder.frame = CGRect(x: 0, y: Name.frame.size.height - nameFieldwidth, width:  Name.frame.size.width, height: Name.frame.size.height)
        
        nameFieldborder.borderWidth = nameFieldwidth
        Name.layer.addSublayer(nameFieldborder)
        Name.layer.masksToBounds = true
        
        let progressAmountborder = CALayer()
        let progressAmountwidth = CGFloat(2.0)
        progressAmountborder.borderColor = UIColor.darkGray.cgColor
        progressAmountborder.frame = CGRect(x: 0, y: RemainingProgress.frame.size.height - progressAmountwidth, width:  RemainingProgress.frame.size.width, height: RemainingProgress.frame.size.height)
        
        progressAmountborder.borderWidth = progressAmountwidth
        RemainingProgress.layer.addSublayer(progressAmountborder)
        RemainingProgress.layer.masksToBounds = true
    }

    func done(){
        dismiss(animated: true, completion: nil)
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
            pickerLabel?.textAlignment = .left
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
