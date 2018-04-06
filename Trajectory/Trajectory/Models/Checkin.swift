//
//  Checkin.swift
//  Trajectory
//
//  Created by Jeremy Bost on 3/12/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import Foundation

class Checkin: Codable {
    enum Status: String, Codable {
        case good, fine, poor
    }
    
    var status: Status?
    var sentDate: Date?
    
    var id: String? = nil
    
    enum CodingKeys: String, CodingKey {
        case status, sentDate
    }
}
