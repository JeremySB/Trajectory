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
    
    func testEmailLogin() {
        XCTAssertTrue(app.textFields["Email Address"].exists)
        
        let emailTextField = app.textFields["Email Address"]
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
    
    func testInvalidCredentials() {
        let emailTextField = app.textFields["Email Address"]
        XCTAssertTrue(emailTextField.exists)
        emailTextField.tap()
        
        let continueButton = app.buttons["Continue"]
        continueButton.tap()
        XCTAssertTrue(emailTextField.exists)
        emailTextField.tap()
        emailTextField.typeText("test")
        //app.otherElements.containing(.navigationBar, identifier:"Trajectory").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.tap()
        continueButton.tap()
        XCTAssertTrue(emailTextField.exists)
        emailTextField.tap()
        emailTextField.typeText("@test")
        continueButton.tap()
        XCTAssertTrue(emailTextField.exists)
        emailTextField.tap()
        emailTextField.typeText("uitest@gettrajectory.com")
        continueButton.tap()
        
        let passwordSecureTextField = app.secureTextFields["Password"]
        XCTAssertTrue(passwordSecureTextField.exists)
        XCTAssertFalse(emailTextField.exists)
        passwordSecureTextField.tap()
        
        let nextButton = app.buttons["Next"]
        nextButton.tap()
        XCTAssertTrue(passwordSecureTextField.exists)
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText("password")
        app.otherElements.containing(.navigationBar, identifier:"Enter Your Password").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.tap()
        nextButton.tap()
        XCTAssertTrue(passwordSecureTextField.exists)
    }
    
}
