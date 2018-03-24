//
//  HobbiesInterestsViewController.swift
//  Trajectory
//
//  Created by Andrew Vogel on 1/23/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import UIKit
import Firebase
import CodableFirebase
//import QuarzCore

class HobbiesInterestsViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var nextBtn: UIButton!
    //Character limit
    let limitLength = 250
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hobbies.delegate = self
        professionalInterests.delegate = self
        
        hobbies.text = "What are your hobbies?"
        hobbies.textColor = UIColor.lightGray
        
        professionalInterests.text = "What are your professional interests?"
        professionalInterests.textColor = UIColor.lightGray
        
        nextBtn.layer.borderColor = UIColor.lightGray.cgColor
        nextBtn.layer.borderWidth = 2
        nextBtn.layer.cornerRadius = 5

        // Do any additional setup after loading the view.
        navigationItem.title = "Profile Setup"
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.white
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = "" //textView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: text)
        return updatedText.count <= limitLength
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    @IBOutlet weak var hobbies: UITextView!
    @IBOutlet weak var professionalInterests: UITextView!
    
    // MARK: - Navigation

    @IBAction func didTapNext(_ sender: Any) {
        let db = Firestore.firestore()
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        let user = User()
        user.hobbies = hobbies.text
        user.professionalInterests = professionalInterests.text
        let userEncoded = try! FirestoreEncoder().encode(user)
        
        db.collection("users").document(uid)
            .setData(userEncoded,
                     options: SetOptions.merge()) { (error) in
            if let error = error {
                print(error.localizedDescription)
            }
            else {
                self.performSegue(withIdentifier: "hobbiesAndInterestsToDenominationAndGoals", sender: self)
            }
        }
    }
    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
}
