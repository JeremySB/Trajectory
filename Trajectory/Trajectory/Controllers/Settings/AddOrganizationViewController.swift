//
//  AddOrganizationViewController.swift
//  Trajectory
//
//  Created by Andrew Vogel on 1/25/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import UIKit

class AddOrganizationViewController: UIViewController {
    
    lazy var orgService: OrganizationService = FirebaseOrganizationService()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    @IBAction func doneButton(_ sender: Any) {
        if firstThreeCharacters.text?.count == 3 && lastThreeCharacters.text?.count == 3,
            let code = Int(firstThreeCharacters.text! + lastThreeCharacters.text!) {
            print(code)
            orgService.joinOrganization(code: code, completion: { (error) in
                if error == nil {
                    self.dismiss(animated: true, completion: nil)
                } else {
                    self.invalidCodeErrorMessage.isHidden = false
                    self.firstThreeCharacters.text = ""
                    self.lastThreeCharacters.text = ""
                    self.lastThreeCharacters.resignFirstResponder()
                }
            })
        }
        else {
            
        }
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var firstThreeCharacters: UITextField!
    
    @IBOutlet weak var lastThreeCharacters: UITextField!
    
    @IBOutlet weak var invalidCodeErrorMessage: UILabel!
    
    @IBAction func checkFirstCodeLength(_ sender: Any) {
        let codeLength = firstThreeCharacters.text?.count
        if codeLength! > 2 {
            lastThreeCharacters.becomeFirstResponder()
        }
    }
    
    @IBAction func dismissKeyboardFirstThreeCharacters(_ sender: Any) {
            firstThreeCharacters.resignFirstResponder()
    }
    
    @IBAction func checkLastCodeLength(_ sender: Any) {
        let codeLength = lastThreeCharacters.text?.count
        if codeLength! > 2 {
            lastThreeCharacters.resignFirstResponder()
        }
    }
    
    @IBAction func dismissKeyboardLastThreeCharacters(_ sender: Any) {
        lastThreeCharacters.resignFirstResponder()
    }
    
    // Set status bar to white text
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
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
