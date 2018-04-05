//
//  GoalsProgressView.swift
//  Trajectory
//
//  Created by student on 4/5/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import UIKit

class GoalsProgressView: UIProgressView {
    
    func setup(ySize: CGFloat, cornerRadius: CGFloat){
        
        //transform = CGAffineTransform(scaleX: 1.0, y: ySize)
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
