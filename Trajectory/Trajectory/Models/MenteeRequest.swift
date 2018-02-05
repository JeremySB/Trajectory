//
//  MenteeRequest.swift
//  Trajectory
//
//  Created by Jeremy Bost on 2/1/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import Foundation

class MenteeRequest: Codable {
    var mentee: Mentee
    
    init(by mentee: Mentee) {
        self.mentee = mentee
    }
    
    func accept(until date: Date) {
        
    }
    
    func decline() {
        
    }
}
