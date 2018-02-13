//
//  DelayTextFieldSearch.swift
//  Trajectory
//
//  Created by Andrew Vogel on 2/13/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import Foundation
import UIKit


//Class from https://stackoverflow.com/questions/45527222/swift-run-code-1-second-after-a-user-stops-typing-into-a-textfield
//Used to set up search to only trigger after user stops typing for 1 second

@IBDesignable
class DelayTextFieldSearch: UITextField {
    
    @IBInspectable var delayValue : Double = 1.0
    var timer:Timer?
    
    var actionClosure : (()->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addTarget(self, action: #selector(changedTextFieldValue), for: .editingChanged)
    }
    
    @objc func changedTextFieldValue(){
        timer?.invalidate()
        //setup timer
        timer = Timer.scheduledTimer(timeInterval: delayValue, target: self, selector: #selector(self.executeAction), userInfo: nil, repeats: false)
    }
    
    @objc func executeAction(){
        actionClosure?()
    }
    
}
