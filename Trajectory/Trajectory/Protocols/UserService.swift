//
//  UserService.swift
//  Trajectory
//
//  Created by Jeremy Bost on 2/8/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

protocol UserService {
    func getUser(uid: String, completion: @escaping (User?, UserServiceError?) -> Void)
    
    func getCurrentUser(_ completion: @escaping (User?, UserServiceError?) -> Void)
    
    func saveCurrentUser(_: User, completion: ((UserServiceError?) -> Void)?)
    
    func getAllAvailableMentors(completion: @escaping ([User]?, UserServiceError?) -> Void)
    
    func addCurrentUserListener(_ update: @escaping (User?, UserServiceError?) -> Void)
}

enum UserServiceError: Error {
    case NoUserData
    case InvalidUserData
    case NotLoggedIn
    case Misc(String)
}
