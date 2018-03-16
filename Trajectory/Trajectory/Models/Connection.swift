//
//  Connection.swift
//  Trajectory
//
//  Created by Jeremy Bost on 2/27/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//
import UIKit

class Connection: Codable {
    enum Status: String, Codable {
        case accepted, pending, rejected, ended
    }
    var mentee: String?
    var mentor: String?
    var mentorshipEndDate: Date?
    var mentorStatus: Status?
    
    var id: String? = nil
    
    enum CodingKeys: String, CodingKey {
        case mentee, mentor, mentorStatus, mentorshipEndDate
    }
}
