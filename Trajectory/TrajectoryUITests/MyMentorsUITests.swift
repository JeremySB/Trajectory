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
    
    func testMentorCancelMentorship() {
        app.tabBars.buttons["Community"].tap()
        app.collectionViews.cells.otherElements.containing(.staticText, identifier:"Andy McGee").element.tap()
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.swipeLeft()
        app.tables/*@START_MENU_TOKEN@*/.buttons["Cancel Mentorship"]/*[[".cells.buttons[\"Cancel Mentorship\"]",".buttons[\"Cancel Mentorship\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.sheets["Please confirm that you want to cancel this mentorship"].buttons["Confirm"].tap()        
    }
    
    func testContactMentor() {
        app.tabBars.buttons["Community"].tap()
        app.collectionViews.cells.otherElements.containing(.image, identifier:"profileImg").element.tap()
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element/*@START_MENU_TOKEN@*/.swipeLeft()/*[[".swipeUp()",".swipeLeft()"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        app.tables/*@START_MENU_TOKEN@*/.buttons["Contact Mentor"]/*[[".cells.buttons[\"Contact Mentor\"]",".buttons[\"Contact Mentor\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    }
    
    func testMentorBackButton() {
        app.tabBars.buttons["Community"].tap()
        app.collectionViews.cells.otherElements.containing(.image, identifier:"profileImg").element.tap()
        app.navigationBars["Mentor"].buttons["Mentors"].tap()
    }
    
    func testContactMentee() {
        app.tabBars.buttons["Community"].tap()
        
        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        element.children(matching: .collectionView).element.swipeLeft()
        app.collectionViews.cells.otherElements.containing(.staticText, identifier:"Andy McGee").element.tap()
        element.swipeLeft()
        app.tables/*@START_MENU_TOKEN@*/.buttons["Contact Mentee"]/*[[".cells.buttons[\"Contact Mentee\"]",".buttons[\"Contact Mentee\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    }
    
    func testMenteeCancelMentorship() {
        app.tabBars.buttons["Community"].tap()
        
        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        element.children(matching: .collectionView).element.swipeLeft()
        app.collectionViews.cells.otherElements.containing(.staticText, identifier:"Andy McGee").element.tap()
        element.swipeLeft()
        app.tables/*@START_MENU_TOKEN@*/.buttons["Cancel Mentorship"]/*[[".cells.buttons[\"Cancel Mentorship\"]",".buttons[\"Cancel Mentorship\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.sheets["Please confirm that you want to cancel this mentorship"].buttons["Confirm"].tap()
    }
    
    func testMenteeBackButton() {
        app.tabBars.buttons["Community"].tap()
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .collectionView).element.swipeLeft()
        app.collectionViews.cells.otherElements.containing(.staticText, identifier:"Andrew Vogel").element.tap()
        app.navigationBars["Mentee"].buttons["Mentees"].tap()
    }
}
