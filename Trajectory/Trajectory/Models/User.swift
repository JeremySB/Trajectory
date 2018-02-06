//
//  User.swift
//  Trajectory
//
//  Created by Jeremy Bost on 2/5/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import Foundation

class User: Codable {
    var name: String?
    var organization: String?
    var hobbies: String?
    var professionalInterests: String?
    var denomination: String?
    var objectives: String?
    var phoneNumber: String?
    var emailAddress: String?
    
    init(testname: String) {
        // init for test data
        name = testname
    }
    
    init() {
        
    }
}
