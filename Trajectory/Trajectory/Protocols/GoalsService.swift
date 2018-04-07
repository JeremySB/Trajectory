//
//  GoalsService.swift
//  Trajectory
//
//  Created by Jeremy Bost on 2/11/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

protocol GoalsService {
    func addGoal(_: Goal, completion: ((GoalsServiceError?) -> Void)?)
    
    func getGoals(completion: @escaping ([Goal]?, GoalsServiceError?) -> Void)
    
    func getGoals(_ uid: String, completion: @escaping ([Goal]?, GoalsServiceError?) -> Void)
    
    func addGoalsListener(_: @escaping ([Goal]?, GoalsServiceError?) -> Void)
    func addGoalsListener(_ uid: String, update: @escaping ([Goal]?, GoalsServiceError?) -> Void)
    
    func removeGoal(_ : Goal, completion: ((GoalsServiceError?) -> Void)?)
    
    func editGoal(_ goal: Goal, completion: ((GoalsServiceError?) -> Void)?)
}

enum GoalsServiceError: Error {
    case NotLoggedIn
    case InvalidData
    case Misc(String)
}
