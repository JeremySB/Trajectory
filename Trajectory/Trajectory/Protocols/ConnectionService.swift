//
//  ConnectionService.swift
//  Trajectory
//
//  Created by Jeremy Bost on 2/27/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

protocol ConnectionService {
    func sendMentorRequest(to user: String, completion: ((ConnectionServiceError?) -> Void)?)
}

enum ConnectionServiceError: Error {
    case NotLoggedIn
    case Misc(String)
}
