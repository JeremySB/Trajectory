//
//  ImageService.swift
//  Trajectory
//
//  Created by Jeremy Bost on 3/20/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import Foundation

protocol ImageService {
    
}

enum ImageServiceError: Error {
    case NotLoggedIn
    case InvalidServerData
    case InvalidInputData
    case Misc(String)
}
