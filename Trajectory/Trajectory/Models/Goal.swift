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
    var targetPerDay: Int?
    var targetPerWeek: Int?
    var targetPerMonth: Int?
    var startDate: Date?
    var endDate: Date?
    
    var id: String? = nil
    
    enum CodingKeys: String, CodingKey {
        case owner, totalProgress, currentProgress, title, targetPerDay, targetPerWeek, targetPerMonth, startDate, endDate
    }
}
