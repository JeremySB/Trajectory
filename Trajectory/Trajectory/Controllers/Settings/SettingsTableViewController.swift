//
//  SettingsTableViewController.swift
//  Trajectory
//
//  Created by Andrew Vogel on 1/28/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import UIKit
import Firebase
import CropViewController

class SettingsTableViewController: UITableViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate, CropViewControllerDelegate {
    
    lazy var userService: UserService = FirebaseUserService()
    lazy var authService: AuthenticationService = FirebaseAuthenticationService()
    lazy var imageService: ImageService = FirebaseImageService()
    private var croppingStyle = CropViewCroppingStyle.default
    private var croppedRect = CGRect.zero
    private var croppedAngle = 0
    
    var user: User?
    var uidForProfileImage: String? {
        didSet {
            if let uid = uidForProfileImage {
                self.imageService.bindProfileImage(for: uid, to: self.profileImage)
            }
        }
    }
    
    // make status bar white
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
       
        //Create tap gesture for profile image (https://stackoverflow.com/questions/27880607/how-to-assign-an-action-for-uiimageview-object-in-swift)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        profileImage.isUserInteractionEnabled = true
        profileImage.addGestureRecognizer(tapGestureRecognizer)
        
        loadUser()
        
        //Set background
        let imageView = UIImageView(image: UIImage(named: "TrajectoryBackground"))
        imageView.frame = self.tableView.frame
        self.tableView.backgroundView = imageView
        
        self.profileImage.layer.cornerRadius = self.profileImage.frame.size.width / 2;
        self.profileImage.clipsToBounds = true;
        
        logoutButton.layer.borderColor = UIColor.lightGray.cgColor
        logoutButton.layer.borderWidth = 2
        logoutButton.layer.cornerRadius = 5
        
    // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadUser()
    }
    
    func loadUser() {
        userService.getCurrentUser { (user, error) in
            guard let user = user else { return }
            self.user = user
            
            self.userName.text = user.name
            //self.userOrganization.text = user.organization ?? "No Organization"
            
            guard let uid = user.id else { return }
            if uid != self.uidForProfileImage {
                self.uidForProfileImage = uid
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var userOrganization: UILabel!
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBAction func logoutButton(_ sender: Any) {
        if (!authService.signOut()){
            print("signOut Failed!")
        }
    }
    
    @IBOutlet weak var logoutButton: UIButton!
    
    //Function to photo library to update image when tapped (https://stackoverflow.com/questions/27880607/how-to-assign-an-action-for-uiimageview-object-in-swift)
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        //Open photo library (https://turbofuture.com/cell-phones/Access-Photo-Camera-and-Library-in-Swift)
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.modalPresentationStyle = .popover
            //imagePicker.preferredContentSize = CGSize(width: 320, height: 568)
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    

    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image = (info[UIImagePickerControllerOriginalImage] as? UIImage) else {return}
        let cropController = CropViewController(croppingStyle: .circular, image: image)
        cropController.delegate = self
        
        self.profileImage.image = image
        
        picker.pushViewController(cropController, animated: true)
        
    }
    
    public func cropViewController(_ cropViewController: CropViewController, didCropToCircularImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
        self.croppedRect = cropRect
        self.croppedAngle = angle
        
        imageService.saveProfileImage(image, completion: nil)
        
        updateImageViewWithImage(image, fromCropViewController: cropViewController)
    }
    
    public func updateImageViewWithImage(_ image: UIImage, fromCropViewController cropViewController: CropViewController) {
        self.profileImage.image = image
        
        self.navigationItem.rightBarButtonItem?.isEnabled = true
        
        if cropViewController.croppingStyle != .circular{
            self.profileImage.isHidden = true
            cropViewController.dismissAnimatedFrom(self, withCroppedImage: image, toView: profileImage, toFrame: CGRect.zero, setup: { }, completion: {self.profileImage.isHidden = false })
        }
        else{
            self.profileImage.isHidden = false
            cropViewController.dismiss(animated: true, completion: nil)
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }

}
