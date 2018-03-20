//
//  ImageService.swift
//  Trajectory
//
//  Created by Jeremy Bost on 3/20/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import UIKit

protocol ImageService {
    func getProfileImage(for uid: String, completion: @escaping (UIImage?, ImageServiceError?) -> Void)
    func getCurrentProfileImage(_ completion: @escaping (UIImage?, ImageServiceError?) -> Void)
    func saveProfileImage(_ image: UIImage, completion: ((ImageServiceError?) -> Void)?)
    func bindProfileImage(for uid: String, to imageView: UIImageView)
}

enum ImageServiceError: Error {
    case NotLoggedIn
    case InvalidServerData
    case InvalidInputData
    case Misc(String)
}
