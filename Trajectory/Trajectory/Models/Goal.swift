//
//  Goal.swift
//  Trajectory
//
//  Created by student on 2/6/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import Foundation

class Goal: Codable {
    // internal fields
    var owner: String?
    
    // goal information
    var totalProgress: Int?
    var currentProgress: Int?
    var title: String?
    var startDate: Date?
    var endDate: Date?
    
    var id: String? = nil
    
    enum CodingKeys: String, CodingKey {
        case owner, totalProgress, currentProgress, title, startDate, endDate
    }
}
