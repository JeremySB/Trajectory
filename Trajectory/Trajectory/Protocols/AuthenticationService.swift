//
//  AuthenticationService.swift
//  Trajectory
//
//  Created by Jeremy Bost on 2/7/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

protocol AuthenticationService {
    var currentUID: String? { get }
    var signedIn: Bool { get }
    
    func fetchProviders(forEmail email: String, completion: @escaping ([String]?, AuthenticationError?) -> Void)
    
    func signOut() -> Bool
    
    func signIn(withEmail email: String, password: String, completion: ((Error) -> Void)?)
    
    func updateEmail(_ email: String, completion: @escaping (AuthenticationError?) -> Void)
}

enum AuthenticationError: Error {
    case MiscError(String)
    case InvalidEmail(String?)
}
