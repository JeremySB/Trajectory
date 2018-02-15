//
//  LoginTests.swift
//  TrajectoryUITests
//
//  Created by Jeremy Bost on 2/15/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import XCTest

class LoginTests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        app = XCUIApplication()
        app.launchArguments.append("uiTestingLoggedOut")
        app.launch()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        
        app.terminate()
    }
    
    func testLogin() {
        
        XCTAssertTrue(app.textFields["Email"].exists)
        
        let emailTextField = app.textFields["Email"]
        emailTextField.tap()
        emailTextField.typeText("uitest@gettrajectory.com")
        app.buttons["Continue"].tap()
        
        XCTAssertTrue(app.secureTextFields["Password"].exists)
        
        let passwordSecureTextField = app.secureTextFields["Password"]
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText("uitestonly")
        app.buttons["Next"].tap()
                
        XCTAssert(app.navigationBars["Goals"].otherElements["Goals"].exists)
        
    }
    
}
