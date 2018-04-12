//
//  FindCollectionView.swift
//  Trajectory
//
//  Created by student on 2/2/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import UIKit

class FindCollectionView: UICollectionView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    weak var parent : UIViewController!
    
    //Calls this function when the tap is recognized.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.parent.view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }

}
