//
//  UserService.swift
//  Trajectory
//
//  Created by Jeremy Bost on 2/8/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

protocol UserService {
    func getUser(uid: String, completion: @escaping (User?, UserServiceError?) -> Void)
    
    func getMentee(uid: String, completion: @escaping (Mentee?, UserServiceError?) -> Void)
    
    
}

enum UserServiceError: Error {
    case NoUserData
    case InvalidUserData
    case Misc(String)
}
