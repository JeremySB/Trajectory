//
//  GoalsTableViewCell.swift
//  Trajectory
//
//  Created by student on 2/23/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import UIKit

protocol GoalsTableViewCell {
    weak var goal: Goal! {get set}
    weak var parent: GoalsViewController! {get set}
    var cellNum: Int {get set}
    weak var Title: UILabel! {get set}
    weak var Progress: GoalsProgressView! {get set}
    weak var ProgressLabel: UILabel! {get set}
    var updated: Bool {get set}
}
