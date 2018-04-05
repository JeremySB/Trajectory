//
//  MyMentorsUITests.swift
//  TrajectoryUITests
//
//  Created by Andrew Vogel on 4/4/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import XCTest

class MyMentorsUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        app = XCUIApplication()
        app.launchArguments.append("uiTestingLoggedIn")
        app.launch()
        
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        //app = XCUIApplication()
        
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        //XCUIApplication().launch()
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        app.terminate()
    }
    
    func testCheckInButtons() {
        app.tabBars.buttons["Community"].tap()
        app.collectionViews.cells.otherElements.containing(.image, identifier:"profileImg").element.tap()
        app.buttons["Doing Well"].tap()
        
        let checkInConfirmedButton = app.buttons["Check-In Confirmed"]
        checkInConfirmedButton.tap()
        app.buttons["Alright"].tap()
        checkInConfirmedButton.tap()
        app.buttons["Not Good"].tap()
        checkInConfirmedButton.tap()
    }
    
    func testCalendarButton() {
        app.tabBars.buttons["Community"].tap()
        app.collectionViews.cells.otherElements.containing(.image, identifier:"profileImg").element.tap()
        app.buttons["Calendar"].tap()
    }
    
    func testCancelMentorship() {

    }
    
}
