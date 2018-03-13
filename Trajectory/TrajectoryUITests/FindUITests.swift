//
//  FindUITests.swift
//  TrajectoryUITests
//
//  Created by Andrew Vogel on 3/11/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import XCTest

var app: XCUIApplication!

class FindUITests: XCTestCase {
        
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
    
    // --People Find Screen Tests--
    func testPeopleSearchBarValidText() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        app.tabBars.buttons["Find"].tap()
        let searchForPeopleSearchField = app.searchFields["Search for people"]
        searchForPeopleSearchField.tap()
        searchForPeopleSearchField.typeText("andrew")
        /*app.collectionViews.children(matching: .cell).element(boundBy: 0).otherElements.containing(.image, identifier:"profileImg").element.tap()
        app.buttons["Contact Mentor"].tap()
        app.sheets["Please confirm that you want to send this mentee request"].buttons["Confirm"].tap()
        */
    }
    
    func testPeopleSearchBarInvalidText() {
        
    }
    
    func testPeopleSearchBarNoText() {
        
    }
    
    func testPeopleSearchBarCancelButton() {
        
    }
    
    func testPeopleSearchBarSearchButton() {
        
    }
    
    func testPeopleSwipeToLeft() {
        
    }
    
    // --Organization Find Screen Tests--
    func testOrganizationSearchBarValidText() {
        
    }
    
    func testOrganizationSearchBarInvalidText() {
        
    }
    
    func testOrganizationSearchBarNoText() {
        
    }
    
    func testOrganizationSearchBarCancelButton() {
        
    }
    
    func testOrganizationSearchBarSearchButton() {
        
    }
    
    func testOrganizationSwipeToRight() {
        
    }
    
    // --Mentor Information Screen Tests--
    func testContactMentorConfirmButton() {
        
    }
    
    func testContactMentorCancelButton() {
        
    }
}
