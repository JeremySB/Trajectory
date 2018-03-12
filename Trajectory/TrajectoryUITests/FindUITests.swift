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
    
    func testPeopleSearchBar() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        app.tabBars.buttons["Find"].tap()
        let searchForPeopleSearchField = app.searchFields["Search for people"]
        searchForPeopleSearchField.tap()
        app/*@START_MENU_TOKEN@*/.keys["A"]/*[[".keyboards.keys[\"A\"]",".keys[\"A\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        searchForPeopleSearchField.typeText("A")
        app/*@START_MENU_TOKEN@*/.keys["n"]/*[[".keyboards.keys[\"n\"]",".keys[\"n\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        searchForPeopleSearchField.typeText("n")
        app/*@START_MENU_TOKEN@*/.keys["d"]/*[[".keyboards.keys[\"d\"]",".keys[\"d\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        searchForPeopleSearchField.typeText("d")
        app/*@START_MENU_TOKEN@*/.keys["r"]/*[[".keyboards.keys[\"r\"]",".keys[\"r\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        searchForPeopleSearchField.typeText("r")
        app/*@START_MENU_TOKEN@*/.keys["e"]/*[[".keyboards.keys[\"e\"]",".keys[\"e\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        searchForPeopleSearchField.typeText("e")
        app/*@START_MENU_TOKEN@*/.keys["w"]/*[[".keyboards.keys[\"w\"]",".keys[\"w\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        searchForPeopleSearchField.typeText("w")
       /* app.collectionViews.children(matching: .cell).element(boundBy: 0).otherElements.containing(.image, identifier:"profileImg").element.tap()
        app.buttons["Contact Mentor"].tap()
        app.sheets["Please confirm that you want to send this mentee request"].buttons["Confirm"].tap()
        */
    }
    
}
