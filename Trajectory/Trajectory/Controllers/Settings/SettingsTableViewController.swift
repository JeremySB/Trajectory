//
//  SettingsTableViewController.swift
//  Trajectory
//
//  Created by Andrew Vogel on 1/28/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import UIKit
import Firebase

class SettingsTableViewController: UITableViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
    
    var userService: UserService = FirebaseUserService()
    
    var user: User?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        userName.text = user?.name
        userOrganization.text = user?.organization
       
        //Create tap gesture for profile image (https://stackoverflow.com/questions/27880607/how-to-assign-an-action-for-uiimageview-object-in-swift)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        profileImage.isUserInteractionEnabled = true
        profileImage.addGestureRecognizer(tapGestureRecognizer)
        
        loadUser()
        
    // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func loadUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        self.userService.getUser(uid: uid) { (user, error) in
            if let error = error {
                print(error)
            }
            if let user = user {
                self.user = user
                
                // TODO: add some sort of refresh call
            }
        }
    }
    
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var userOrganization: UILabel!
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBAction func logoutButton(_ sender: Any) {
    }
    
    //Function to photo library to update image when tapped (https://stackoverflow.com/questions/27880607/how-to-assign-an-action-for-uiimageview-object-in-swift)
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        //Open photo library (https://turbofuture.com/cell-phones/Access-Photo-Camera-and-Library-in-Swift)
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    

    //Update image (https://turbofuture.com/cell-phones/Access-Photo-Camera-and-Library-in-Swift)
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        profileImage.image = image
        dismiss(animated:true, completion: nil)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
    }

}
