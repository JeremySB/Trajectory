//
//  Goal.swift
//  Trajectory
//
//  Created by student on 2/6/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import Foundation

class Goal{
    var goalID: String?
    var ownerID: String?
    var totalProgress: Int?
    var currentProgress: Int?
    var title: String?
    var targetPerDay: Int?
    var targetPerWeek: Int?
    var targetPerMonth: Int?
    var startDate: String?
    var endDate: String?
    
    init(){
        goalID = "yesGoalID"
        ownerID = "yesOwnerID"
        totalProgress = 100
        currentProgress = 50
        title = "Yaaassss Goal"
        targetPerDay = 2
        targetPerWeek = 3
        targetPerMonth = 200
        startDate = "2/7/2018"
        endDate = "3/1/2018"
    }
    
}
