//
//  CommUserCollectionViewCell.swift
//  Trajectory
//
//  Created by student on 3/11/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import UIKit

class CommUserCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userProfileName: UILabel!
    
    
    func displayContent(image: UIImage, name: String) {
        userImage.image = image
        userProfileName.text = name
    }
}
