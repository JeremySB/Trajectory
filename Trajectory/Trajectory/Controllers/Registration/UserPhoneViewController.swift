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
    
    func formatInput() -> String {
        let rawNumber = phoneNumber.text!
        
        let digits = rawNumber.flatMap{Int(String($0))}
        let areaCode = "\(digits[0])\(digits[1])\(digits[2])"
        let secondSet = "\(digits[3])\(digits[4])\(digits[5])"
        let thirdSet = "\(digits[6])\(digits[7])\(digits[8])\(digits[9])"
        
        let formattedNumber = "(\(areaCode))-\(secondSet)-\(thirdSet)"
        print(formattedNumber)
        return formattedNumber
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
            let formattedPhoneNumber = formatInput()
            errorMessage.isHidden = true
            let user = User()
            user.phoneNumber = formattedPhoneNumber
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
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }

}
