//
//  UserNameViewController.swift
//  Trajectory
//
//  Created by Andrew Vogel on 1/24/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import UIKit
import Firebase
import CodableFirebase

class UserNameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.title = "Profile Setup"
        navigationItem.hidesBackButton = true
        
        userName.attributedPlaceholder = NSAttributedString(string: "  Name", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    @IBOutlet weak var userName: UITextField!
    
    @IBAction func didTapNext(_ sender: Any) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = userName.text
        changeRequest?.commitChanges { (error) in
            if error == nil {
                self.performSegue(withIdentifier: "nameToPhoneAndEmail", sender: self)
            }
        }
        
        let user = User()
        user.name = userName.text
        let userEncoded = try! FirestoreEncoder().encode(user)
        Firestore.firestore().collection("users").document(uid).setData(userEncoded, options: SetOptions.merge())
        
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
}
