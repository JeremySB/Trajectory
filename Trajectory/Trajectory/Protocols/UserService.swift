//
//  UserService.swift
//  Trajectory
//
//  Created by Jeremy Bost on 2/8/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

protocol UserService {
    func getUser(uid: String, completion: @escaping (User?, UserError?) -> Void)
    
    func getMentee(uid: String, completion: @escaping (Mentee?, UserError?) -> Void)
    
    
}

enum UserError: Error {
    case NoUserData
    case InvalidUserData
    case Misc(String)
}
