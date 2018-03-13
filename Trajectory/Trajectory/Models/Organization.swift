//
//  Organization.swift
//  Trajectory
//
//  Created by Jeremy Bost on 2/19/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import Foundation

class Organization: Codable {
    var name: String?
    var publicCode: Int?
    
    var id: String? = nil
    
    enum CodingKeys: String, CodingKey {
        case name, publicCode
    }
}

extension Organization: Hashable {
    var hashValue: Int {
        if let id = id {
            return id.hashValue
        }
        return "".hashValue
    }
    
    static func ==(lhs: Organization, rhs: Organization) -> Bool {
        return lhs.name == rhs.name && lhs.id == rhs.id
    }
    
}
