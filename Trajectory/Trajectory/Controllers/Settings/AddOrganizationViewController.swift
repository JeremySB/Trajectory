//
//  AddOrganizationViewController.swift
//  Trajectory
//
//  Created by Andrew Vogel on 1/25/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import UIKit

class AddOrganizationViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    @IBAction func doneButton(_ sender: Any) {
        if firstThreeCharacters.text?.count == 3 && lastThreeCharacters.text?.count == 3 {
            let code = firstThreeCharacters.text! + lastThreeCharacters.text!
            print(code)
            dismiss(animated: true, completion: nil)
        }
        else {
            invalidCodeErrorMessage.isHidden = false
            firstThreeCharacters.text = ""
            lastThreeCharacters.text = ""
            lastThreeCharacters.resignFirstResponder()
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
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
