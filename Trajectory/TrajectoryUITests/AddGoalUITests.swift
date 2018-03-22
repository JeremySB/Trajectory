//
//  AddGoalUITests.swift
//  TrajectoryUITests
//
//  Created by Andrew Vogel on 3/18/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import XCTest

class AddGoalUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        app = XCUIApplication()
        app.launchArguments.append("uiTestingLoggedIn")
        app.launch()
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        app.terminate()
    }
    
    func testGoalScreenSwipingAndAddGoalButton() {
        XCUIApplication().children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .table).element.swipeRight()
        app.navigationBars["History"].buttons["Add"].tap()
        
        let cancelButton = app/*@START_MENU_TOKEN@*/.navigationBars["Add Goal"]/*[[".otherElements.matching(identifier: \"Add Goal\").navigationBars[\"Add Goal\"]",".navigationBars[\"Add Goal\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.buttons["Cancel"]
        cancelButton.tap()
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element/*@START_MENU_TOKEN@*/.swipeLeft()/*[[".swipeDown()",".swipeLeft()"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        app.navigationBars["Goals"].buttons["Add"].tap()
        cancelButton.tap()
    }
    
    func testAddGoalButtons() {
        app.navigationBars["Goals"].buttons["Add"].tap()
        
        let goalNameTextField = app/*@START_MENU_TOKEN@*/.textFields["Goal Name"]/*[[".otherElements.matching(identifier: \"Add Goal\").textFields[\"Goal Name\"]",".textFields[\"Goal Name\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        goalNameTextField.tap()
        goalNameTextField.typeText("Test Goal")
        
        let textField = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other)["Add Goal"].children(matching: .textField).element(boundBy: 1)
        textField.tap()
        textField.tap()
        textField.typeText("5")
        
        let dateFormatter = DateFormatter()
        let today = Date()
        dateFormatter.dateFormat = "yyyy"
        let year = dateFormatter.string(from: today)
        dateFormatter.dateFormat = "dd"
        let date = dateFormatter.string(from: today)
        dateFormatter.dateFormat = "MMMM"
        let month = dateFormatter.string(from: today)
        
        let datePickersQuery = app/*@START_MENU_TOKEN@*/.datePickers/*[[".otherElements.matching(identifier: \"Add Goal\").datePickers",".datePickers"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        datePickersQuery.pickerWheels[month].swipeUp()
        datePickersQuery.pickerWheels[date].swipeUp()
        datePickersQuery.pickerWheels[year].swipeUp()
        
        app/*@START_MENU_TOKEN@*/.buttons["Daily"]/*[[".otherElements.matching(identifier: \"Add Goal\")",".segmentedControls.buttons[\"Daily\"]",".buttons[\"Daily\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.buttons["Weekly"]/*[[".otherElements.matching(identifier: \"Add Goal\")",".segmentedControls.buttons[\"Weekly\"]",".buttons[\"Weekly\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.buttons["Monthly"]/*[[".otherElements.matching(identifier: \"Add Goal\")",".segmentedControls.buttons[\"Monthly\"]",".buttons[\"Monthly\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.navigationBars["Add Goal"]/*[[".otherElements.matching(identifier: \"Add Goal\").navigationBars[\"Add Goal\"]",".navigationBars[\"Add Goal\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.buttons["Done"].tap()
        
        app.navigationBars["Goals"].buttons["Add"].tap()
        app/*@START_MENU_TOKEN@*/.navigationBars["Add Goal"]/*[[".otherElements.matching(identifier: \"Add Goal\").navigationBars[\"Add Goal\"]",".navigationBars[\"Add Goal\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.buttons["Cancel"].tap()
    }
}
