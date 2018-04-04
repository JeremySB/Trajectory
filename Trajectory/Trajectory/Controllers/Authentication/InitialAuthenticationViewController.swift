//
//  InitialLaunchViewController.swift
//  Trajectory
//
//  Created by Andrew Vogel on 1/23/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import UIKit
import GoogleSignIn

class InitialAuthenticationViewController: UIViewController, GIDSignInUIDelegate {
    
    var destinationVC: UIViewController?
    
    @IBOutlet weak var continueBtn: UIButton!
    
    @IBOutlet weak var emailField: UITextField!
    lazy var authService: AuthenticationService = FirebaseAuthenticationService()
    
    @IBOutlet weak var emailErrorMessage: UILabel!
    
    @IBAction func continueButtonPrimaryActionTriggered(_ sender: Any) {
        guard validateEmail(enteredEmail: (emailField?.text)!) else {
            self.emailField.text = ""
            emailErrorMessage.isHidden = false
            self.emailField.becomeFirstResponder()
            return
        }
        
        authService.fetchProviders(forEmail: (emailField?.text)!) { (providers, error) in
            if let error = error {
                self.emailField.text = ""
                print(error.localizedDescription)
            }
            else if providers?.contains("password") ?? false {
                self.performSegue(withIdentifier: "passwordLogin", sender: self)
            }
            else {
                self.performSegue(withIdentifier: "passwordRegister", sender: self)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailField.attributedPlaceholder = NSAttributedString(string: "Email Address",
                                                              attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        
        continueBtn.layer.borderColor = UIColor.lightGray.cgColor
        continueBtn.layer.cornerRadius = 5
        
        // https://stackoverflow.com/questions/25845855/transparent-navigation-bar-ios
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        //self.navigationController?.navigationBar.isTranslucent = true
        //self.navigationController?.view.backgroundColor = .clear
        
        GIDSignIn.sharedInstance().uiDelegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //try? Auth.auth().signOut()
        
        if authService.signedIn {
            self.performSegue(withIdentifier: "initialToMain", sender: self)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    // Source: https://stackoverflow.com/a/35789191
    func validateEmail(enteredEmail:String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: enteredEmail)
    }
    
    @IBAction func didTapGoogleSignin(_ sender: Any) {
        
        GIDSignIn.sharedInstance().signIn()
    }
    
    @IBAction func didTapFacebookSignin(_ sender: Any) {
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.destinationVC = segue.destination
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let dest = segue.destination as? PasswordAuthenticationViewController {
            dest.userEmail = emailField?.text
        }
        else if let dest = segue.destination as? NewPasswordViewController {
            dest.userEmail = emailField?.text
        }
    }


}
