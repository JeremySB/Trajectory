//
//  textViewWithPlaceholderUITextView.swift
//  Trajectory
//
//  Created by student on 4/3/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import UIKit

class textViewWithPlaceholderUITextView: UITextView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    func viewDidLoad(){
        self.delegate = self
    }
    
    var message = ""
    
    func setMessage(_ message: String) {
        self.message = message
        self.text = message
        self.textColor = UIColor.lightGray
    }
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.white
        }
    }
    
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = message
            textView.textColor = UIColor.lightGray
        }
    }
}


extension textViewWithPlaceholderUITextView: UITextViewDelegate {
    
}
