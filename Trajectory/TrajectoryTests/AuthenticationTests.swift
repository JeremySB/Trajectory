//
//  AuthenticationTests.swift
//  TrajectoryTests
//
//  Created by Jeremy Bost on 2/7/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import XCTest

@testable import Trajectory

class InitialAuthenticationViewControllerTests: XCTestCase {
    
    var controllerUnderTest: InitialAuthenticationViewController!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        controllerUnderTest = InitialAuthenticationViewController()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        controllerUnderTest = nil
    }
    
    func testCorrectEmailValidation() {
        let email = "test@test.com"
        
        XCTAssertTrue(controllerUnderTest.validateEmail(enteredEmail: email))
    }
    
    func testIncorrectEmailValidation() {
        XCTAssertFalse(controllerUnderTest.validateEmail(enteredEmail: ""))
        XCTAssertFalse(controllerUnderTest.validateEmail(enteredEmail: "test"))
        XCTAssertFalse(controllerUnderTest.validateEmail(enteredEmail: "test@"))
        XCTAssertFalse(controllerUnderTest.validateEmail(enteredEmail: "test@test"))
        XCTAssertFalse(controllerUnderTest.validateEmail(enteredEmail: "test.com"))
        XCTAssertFalse(controllerUnderTest.validateEmail(enteredEmail: "@."))
        XCTAssertFalse(controllerUnderTest.validateEmail(enteredEmail: "@test.com"))
        XCTAssertFalse(controllerUnderTest.validateEmail(enteredEmail: "@.com"))
        XCTAssertFalse(controllerUnderTest.validateEmail(enteredEmail: "@test"))
        XCTAssertFalse(controllerUnderTest.validateEmail(enteredEmail: "@test."))
        XCTAssertFalse(controllerUnderTest.validateEmail(enteredEmail: "test@test."))
    }
    
}
