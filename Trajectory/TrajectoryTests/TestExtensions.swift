//
//  TestExtensions.swift
//  TrajectoryTests
//
//  Created by Andrew Vogel on 2/11/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import XCTest

extension XCTestCase {
    public func getTopViewController() -> UIViewController?{
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController{
                topController = presentedViewController
            }
            return topController
        }else{
            return nil
        }
    }
    
} 
