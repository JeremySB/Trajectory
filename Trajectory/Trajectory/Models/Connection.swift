//
//  Connection.swift
//  Trajectory
//
//  Created by Jeremy Bost on 2/27/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//
import UIKit

class Connection: Codable {
    var mentee: String?
    var mentor: String?
    var mentorAccepted: Bool?
    var mentorshipEndDate: Date?
    
    var id: String? = nil
    
    enum CodingKeys: String, CodingKey {
        case mentee, mentor, mentorAccepted, mentorshipEndDate
    }
}
