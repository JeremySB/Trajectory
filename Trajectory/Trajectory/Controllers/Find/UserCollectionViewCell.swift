//
//  UserCollectionViewCell.swift
//  Trajectory
//
//  Created by student on 2/2/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import UIKit

class UserCollectionViewCell: UICollectionViewCell {
    
    struct userCellInfo {
        let name: String
        let image: UIImage
    }
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userProfileName: UILabel!
}
