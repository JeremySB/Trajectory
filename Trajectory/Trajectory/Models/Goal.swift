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
    
    init() {
        totalProgress = 100
        currentProgress = Int(arc4random_uniform( 100 ))
        title = "Yaaassss Goal"
        targetPerDay = 2
        targetPerWeek = 3
        targetPerMonth = 200
    }
    
}
