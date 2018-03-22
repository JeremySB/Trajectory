//
//  UserCollectionViewCell.swift
//  Trajectory
//
//  Created by student on 2/2/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import UIKit

class UserCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userProfileName: UILabel!
    
    lazy var imageService: ImageService = FirebaseImageService()
    
    func displayContent(image: UIImage, name: String) {
        userImage.image = image
        userProfileName.text = name
    }
    
    func displayContent(uid: String?, name: String?) {
        if let uid = uid {
            imageService.bindProfileImage(for: uid, to: self.userImage)
        } else {
            userImage.image = UIImage(named:"profileImg")!
        }
        userProfileName.text = name
    }
}
