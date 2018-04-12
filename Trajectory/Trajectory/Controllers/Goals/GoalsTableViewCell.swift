//
//  GoalsTableViewCell.swift
//  Trajectory
//
//  Created by student on 2/23/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import UIKit

protocol GoalsTableViewCell {
    var goal: Goal! {get set}
    var parent: GoalsTableViewController! {get set}
    var cellNum: Int {get set}
    var Title: UILabel! {get set}
    var Progress: GoalsProgressView! {get set}
    var ProgressLabel: UILabel! {get set}
    var updated: Bool {get set}
}
