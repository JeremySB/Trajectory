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
    func decline(menteeRequest: MenteeRequest, completion: ((ConnectionServiceError?) -> Void)?)
    func set(endDate: Date, with mentee: User, completion: ((ConnectionServiceError?) -> Void)?)
    func addMenteesListener(_ update: @escaping ([User]?, ConnectionServiceError?) -> Void)
    func addMentorsListener(_ update: @escaping ([User]?, ConnectionServiceError?) -> Void)
    func addCheckin(_ checkin: Checkin, with mentor: User, completion: ((ConnectionServiceError?) -> Void)?)
    func addCheckinsListener(from menteeId: String, to mentorId: String, update: @escaping ([Checkin]?, ConnectionServiceError?) -> Void)
    func addLatestCheckinListener(from menteeId: String, to mentorId: String, update: @escaping (Checkin?, ConnectionServiceError?) -> Void)
    
    func getConnection(_ id: String, completion: @escaping (Connection?, ConnectionServiceError?) -> Void)
    func getConnectionBetween(mentee menteeId: String, mentor mentorId: String, completion: @escaping (Connection?, ConnectionServiceError?) -> Void)
    func saveConnection(_ connection: Connection, completion: ((ConnectionServiceError?) -> Void)?)
    
    func requestCheckin(from mentee: User, completion: ((ConnectionServiceError?) -> Void)?)
}

enum ConnectionServiceError: Error {
    case NotLoggedIn
    case InvalidServerData
    case InvalidInputData
    case Misc(String)
}
