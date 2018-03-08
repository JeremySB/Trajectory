//
//  ConnectionService.swift
//  Trajectory
//
//  Created by Jeremy Bost on 2/27/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import UIKit

protocol ConnectionService {
    func sendMentorRequest(to user: String, completion: ((ConnectionServiceError?) -> Void)?)
    func addOpenMenteeRequestsListener(_ update: @escaping ([MenteeRequest]?, ConnectionServiceError?) -> Void)
    func accept(menteeRequest: MenteeRequest, until endDate: Date, completion: ((ConnectionServiceError?) -> Void)?)
}

enum ConnectionServiceError: Error {
    case NotLoggedIn
    case InvalidServerData
    case InvalidInputData
    case Misc(String)
}
