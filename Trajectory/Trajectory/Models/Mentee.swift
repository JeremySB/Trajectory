//
//  Mentee.swift
//  Trajectory
//
//  Created by Jeremy Bost on 2/1/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import Foundation

class Mentee {
    var name: String
    var organization: String?
    var hobbies: String?
    var professionalInterests: String?
    var denomination: String?
    var menteeObjectives: String?
    var phoneNumber: String?
    var emailAddress: String?
    var uid: String
    
    init(testname: String) {
        // init for test data
        uid = "test"
        name = testname
    }
    
    init(uid: String) {
        // TODO: pull in from Firebase for this user
        self.uid = uid
        name = "Testname Lastname"
    }
    
}
