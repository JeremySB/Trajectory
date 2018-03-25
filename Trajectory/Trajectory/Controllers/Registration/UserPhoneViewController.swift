//
//  PhoneEmailViewController.swift
//  Trajectory
//
//  Created by Andrew Vogel on 1/23/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import UIKit
import Firebase
import CodableFirebase

class UserPhoneViewController: UIViewController {

    @IBOutlet weak var nextBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        phoneNumber.attributedPlaceholder = NSAttributedString(string: "Phone Number", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])

        nextBtn.layer.borderColor = UIColor.lightGray.cgColor
        nextBtn.layer.borderWidth = 2
        nextBtn.layer.cornerRadius = 5
        
        // Do any additional setup after loading the view.
        navigationItem.title = "Profile Setup"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    @IBAction func formatInput(_ sender: Any) {
        let newLength = phoneNumber.text?.count ?? 0

        //Only trigger when entire phone number is entered
        let num = Int((phoneNumber.text ?? nil)!)
        if newLength == 10 && num != nil {
            
        }
        else {
            
        }
        /*if newLength > length {
            //When area code has been entered...
            if newLength == 3 {
                phoneNumber.text = "(" + phoneNumber.text! + ")-"
                newLength = newLength + 3
            }
            //When next three digits have been entered...
            else if newLength == 9 {
                phoneNumber.text = phoneNumber.text! + "-"
                newLength = newLength + 1
            }
            //When last three digits have been entered...
            else if newLength == 14 {
                phoneNumber.resignFirstResponder()
            }
            //If phone number is invalid
            else if newLength == 15 {
                errorMessage.isHidden = false
            }
        }
        else {
            if newLength =
        }*/
    }
    
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var errorMessage: UILabel!
    
    
    @IBAction func didTapNext(_ sender: Any) {
        let db = Firestore.firestore()
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        //Error check before continuing
        let num = Int((phoneNumber.text ?? nil)!)
        let length = phoneNumber.text?.count ?? 0
        if(length == 10 && num != nil) {
            errorMessage.isHidden = true
            let user = User()
            user.phoneNumber = phoneNumber.text
            let userEncoded = try! FirestoreEncoder().encode(user)
            db.collection("users").document(uid).setData(userEncoded, options: SetOptions.merge()) { (error) in
                if let error = error {
                    print(error.localizedDescription)
                }
                else {
                    self.performSegue(withIdentifier: "phoneToHobbiesAndInterests", sender: self)
                }
            }
        } else {
            errorMessage.isHidden = false
        }
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
