//
//  DenominationAndProfileGoalsViewController.swift
//  Trajectory
//
//  Created by Andrew Vogel on 1/23/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import UIKit
import Firebase
import CodableFirebase

class DenominationAndProfileGoalsViewController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var finishBtn: UIButton!
    
    @IBOutlet weak var objectivesErrorMessage: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        objectivesStatement.viewDidLoad()
        objectivesStatement.setMessage("What would you like to work on with a mentor?")
        
        finishBtn.layer.borderColor = UIColor.lightGray.cgColor
        finishBtn.layer.borderWidth = 2
        finishBtn.layer.cornerRadius = 5
        
        denomination.attributedPlaceholder = NSAttributedString(string: "  Denomination", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])

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
    
    @IBOutlet weak var denomination: UITextField!
    @IBOutlet weak var objectivesStatement: textViewWithPlaceholderUITextView!
    
    // MARK: - Navigation

    @IBAction func didTapNext(_ sender: Any) {
        let db = Firestore.firestore()
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        //Check for required field
        if objectivesStatement.text != "" && objectivesStatement.text != "What would you like to work on with a mentor?" && objectivesStatement.text != " " {
            let user = User()
            user.denomination = denomination.text
            user.objectives = objectivesStatement.text
            let userEncoded = try! FirestoreEncoder().encode(user)
            
            db.collection("users").document(uid)
                .setData(userEncoded,
                         options: SetOptions.merge())
                { (error) in
                    if let error = error {
                        print(error.localizedDescription)
                    }
                    else {
                        self.performSegue(withIdentifier: "denominationAndProfileToMain", sender: self)
                    }
            }
        } else {
            objectivesErrorMessage.isHidden = false
        }
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
