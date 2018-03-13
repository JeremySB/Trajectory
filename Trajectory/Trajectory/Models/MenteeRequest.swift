//
//  MenteeRequest.swift
//  Trajectory
//
//  Created by Jeremy Bost on 2/1/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import Foundation

class MenteeRequest: Codable {
    var mentee: User
    var connectionId: String
    
    init(by mentee: User, with id: String) {
        self.mentee = mentee
        self.connectionId = id
    }
}
