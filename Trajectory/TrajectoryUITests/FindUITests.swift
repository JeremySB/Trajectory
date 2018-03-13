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
        app.tabBars.buttons["Find"].tap()
        let searchForPeopleSearchField = app.searchFields["Search for people"]
        searchForPeopleSearchField.tap()
        searchForPeopleSearchField.typeText("Andrew")
        app.collectionViews.children(matching: .cell).element(boundBy: 0).otherElements.containing(.image, identifier:"profileImg").element.tap()
        app.buttons["Contact Mentor"].tap()
        app.sheets["Please confirm that you want to send this mentee request"].buttons["Confirm"].tap()
    }
    
    func testPeopleSearchBarInvalidText() {
        app.tabBars.buttons["Find"].tap()
        let searchForPeopleSearchField = app.searchFields["Search for people"]
        searchForPeopleSearchField.tap()
        searchForPeopleSearchField.typeText("adfsklj;asdf")
        XCTAssertFalse(app.collectionViews.children(matching: .cell).element(boundBy: 0).otherElements.containing(.image, identifier:"profileImg").element.exists)
    }
    
    func testPeopleSearchBarNoText() {
        app.tabBars.buttons["Find"].tap()
        let searchForPeopleSearchField = app.searchFields["Search for people"]
        searchForPeopleSearchField.tap()
        searchForPeopleSearchField.typeText("")
        XCTAssertFalse(app.collectionViews.children(matching: .cell).element(boundBy: 0).otherElements.containing(.image, identifier:"profileImg").element.exists)
    }
    
    func testPeopleSearchBarCancelButton() {
        app.tabBars.buttons["Find"].tap()
        let searchForPeopleSearchField = app.searchFields["Search for people"]
        searchForPeopleSearchField.tap()
        searchForPeopleSearchField.typeText("Andrew")
        app.buttons["Cancel"].tap()
        XCTAssertFalse(app.collectionViews.children(matching: .cell).element(boundBy: 0).otherElements.containing(.image, identifier:"profileImg").element.exists)
    }
    
    func testPeopleSwipeToLeft() {
        app.tabBars.buttons["Find"].tap()
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .collectionView).element.swipeLeft()
        XCTAssert(app.searchFields["Search for people"].exists)
    }
    
    // --Organization Find Screen Tests--
    func testOrganizationSearchBarValidText() {
        app.tabBars.buttons["Find"].tap()
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .collectionView).element.swipeLeft()
        let searchForPeopleSearchField = app.searchFields["Search for people"]
        searchForPeopleSearchField.tap()
        searchForPeopleSearchField.typeText("Andrew")
        app.collectionViews.cells.otherElements.containing(.image, identifier:"profileImg").element.tap()
        app.buttons["Contact Mentor"].tap()
        app.sheets["Please confirm that you want to send this mentee request"].buttons["Confirm"].tap()
    }
    
    func testOrganizationSearchBarInvalidText() {
        app.tabBars.buttons["Find"].tap()
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .collectionView).element.swipeLeft()
        let searchForPeopleSearchField = app.searchFields["Search for people"]
        searchForPeopleSearchField.tap()
        searchForPeopleSearchField.typeText("fdjkl;fda")
        XCTAssertFalse(app.collectionViews.cells.otherElements.containing(.image, identifier:"profileImg").element.exists)
    }
    
    func testOrganizationSearchBarNoText() {
        app.tabBars.buttons["Find"].tap()
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .collectionView).element.swipeLeft()
        let searchForPeopleSearchField = app.searchFields["Search for people"]
        searchForPeopleSearchField.tap()
        searchForPeopleSearchField.typeText("")
        XCTAssertFalse(app.collectionViews.cells.otherElements.containing(.image, identifier:"profileImg").element.exists)
    }
    
    func testOrganizationSearchBarCancelButton() {
        app.tabBars.buttons["Find"].tap()
        let searchForPeopleSearchField = app.searchFields["Search for people"]
        searchForPeopleSearchField.tap()
        searchForPeopleSearchField.typeText("Andrew")
        app.buttons["Cancel"].tap()
        XCTAssertFalse(app.collectionViews.children(matching: .cell).element(boundBy: 0).otherElements.containing(.image, identifier:"profileImg").element.exists)
    }
    
    func testOrganizationSwipeToRight() {
        app.tabBars.buttons["Find"].tap()
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .collectionView).element.swipeLeft()
        XCTAssert(app.searchFields["Search for people"].exists)
    }
    
    // --Mentor Information Screen Test--
    func testContactMentorCancelButton() {
        app.tabBars.buttons["Find"].tap()
        let searchForPeopleSearchField = app.searchFields["Search for people"]
        searchForPeopleSearchField.tap()
        searchForPeopleSearchField.typeText("Andrew")
        app.collectionViews.children(matching: .cell).element(boundBy: 0).otherElements.containing(.image, identifier:"profileImg").element.tap()
        app.buttons["Contact Mentor"].tap()
        app.sheets["Please confirm that you want to send this mentee request"].buttons["Cancel"].tap()
        app.navigationBars["Find Mentor - People"].buttons["Find Mentor - People"].tap()
    }
}
