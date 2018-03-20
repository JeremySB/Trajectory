//
//  FirebaseImageService.swift
//  Trajectory
//
//  Created by Jeremy Bost on 3/20/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseAuth
import FirebaseStorageUI

class FirebaseImageService: ImageService {
    let defaultImg = UIImage(named: "profileImg")
    
    func getCurrentProfileImage(_ completion: @escaping (UIImage?, ImageServiceError?) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {
            completion(nil, .NotLoggedIn)
            return
        }
        getProfileImage(for: uid, completion: completion)
    }
    
    func getProfileImage(for uid: String, completion: @escaping (UIImage?, ImageServiceError?) -> Void) {
        Storage.storage().reference(withPath: StorageValues.profileImages + "/" + uid).getData(maxSize: 1 * 1024 * 1024) { (data, error) in
            if let data = data, let img = UIImage(data: data) {
                completion(img, nil)
            }
            else if let error = error {
                completion(nil, .Misc(error.localizedDescription))
            }
            else {
                completion(nil, .InvalidServerData)
            }
        }
    }
    
    func bindProfileImage(for uid: String, to imageView: UIImageView) {
        let ref = Storage.storage().reference(withPath: StorageValues.profileImages + "/" + uid)
        imageView.sd_setImage(with: ref, placeholderImage: defaultImg)
    }
    
    func saveProfileImage(_ image: UIImage, completion: ((ImageServiceError?) -> Void)?) {
        guard let uid = Auth.auth().currentUser?.uid else {
            completion?(.NotLoggedIn)
            return
        }
        guard let imgData = UIImage.compress(image: image, maxFileSizeInKb: 500) else {
            completion?(.InvalidInputData)
            return
        }
        
        let metadata = StorageMetadata()
        metadata.cacheControl = "max-age=10000"
        
        Storage.storage().reference(withPath: StorageValues.profileImages + "/" + uid).putData(imgData, metadata: metadata) { (storageMetadata, error) in
            if let error = error {
                completion?(.Misc(error.localizedDescription))
            }
            else {
                completion?(nil)
            }
        }
    }
}
