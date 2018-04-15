//
//  GoalsTableViewTests.swift
//  TrajectoryUITests
//
//  Created by student on 3/20/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import XCTest

class GoalsTableViewTests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        let app = XCUIApplication()
        app.launchArguments.append("uiTestingLoggedIn")
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    /*func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }*/
    
    func testExpandCell() {
        
        let app = XCUIApplication();
        
        if (app.tables.count < 1){
            goalMakerHelper(app: app)
        }
        app.tables.otherElements["Progress"].firstMatch.tap()
        //app.tables.cells
    }
    
    func testCollapseCell() {
        let app = XCUIApplication();
        
        if (app.tables.count < 1){
            goalMakerHelper(app: app)
        }
        app.tables.otherElements["Progress"].firstMatch.tap()
        app.tables.otherElements["Progress"].firstMatch.tap()
    }
    
    func testDefaultIncrement() {
        let app = XCUIApplication();
        
        if (app.tables.count < 1){
            goalMakerHelper(app: app)
        }
        let tablesQuery = app.tables
        tablesQuery.otherElements["Progress"].firstMatch.tap()
        tablesQuery.buttons["+"].firstMatch.tap()
        //tablesQuery/*@START_MENU_TOKEN@*/.buttons["Retract"]/*[[".cells.buttons[\"Retract\"]",".buttons[\"Retract\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.firstMatch.tap()
    }
    func testDefaultDecrement() {
        let app = XCUIApplication();
        
        if (app.tables.count < 1){
            goalMakerHelper(app: app)
        }
        let tablesQuery = app.tables
        tablesQuery.otherElements["Progress"].firstMatch.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["-"]/*[[".cells.buttons[\"-\"]",".buttons[\"-\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.firstMatch.tap()
        //tablesQuery/*@START_MENU_TOKEN@*/.buttons["Retract"]/*[[".cells.buttons[\"Retract\"]",".buttons[\"Retract\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.firstMatch.tap()
        
    }
    func testCustomIncrement() {
        
        let app = XCUIApplication();
        
        if (app.tables.count < 1){
            goalMakerHelper(app: app)
        }
        let tablesQuery = app.tables
        tablesQuery.otherElements["Progress"].firstMatch.tap()
        
        let textField = tablesQuery.cells.firstMatch.children(matching: .textField).element
        textField.tap()
        
        //let deleteKey = app/*@START_MENU_TOKEN@*/.keyboards.keys["Delete"]/*[[".keyboards.keys[\"Delete\"]",".keys[\"Delete\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/
        //deleteKey.tap()
        //deleteKey.tap()
        textField.typeText("5")
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["+"]/*[[".cells.buttons[\"+\"]",".buttons[\"+\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.firstMatch.tap()
        tablesQuery.otherElements["Progress"].firstMatch.tap()
    }
    func testCustomDecrement() {
        
        let app = XCUIApplication();
        
        if (app.tables.count < 1){
            goalMakerHelper(app: app)
        }
        let tablesQuery2 = app.tables
        let tablesQuery = tablesQuery2
        tablesQuery.otherElements["Progress"].firstMatch.tap()
        
        let textField = tablesQuery2.cells.firstMatch.children(matching: .textField).element
        textField.tap()
        
        /*let deleteKey = app/*@START_MENU_TOKEN@*/.keys["Delete"]/*[[".keyboards.keys[\"Delete\"]",".keys[\"Delete\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        deleteKey.tap()
        deleteKey.tap()*/
        textField.typeText("5")
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["-"]/*[[".cells.buttons[\"-\"]",".buttons[\"-\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.firstMatch.tap()
        tablesQuery.otherElements["Progress"].firstMatch.tap()
        
    }
    func testEditButton() {
        let app = XCUIApplication();
        
        if (app.tables.count < 1){
            goalMakerHelper(app: app)
        }
        let tablesQuery = app.tables
        tablesQuery.otherElements["Progress"].firstMatch.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Edit"]/*[[".cells.buttons[\"Edit\"]",".buttons[\"Edit\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.firstMatch.tap()
        
        let goalNameTextField = app/*@START_MENU_TOKEN@*/.textFields["Goal Name"]/*[[".otherElements[\"Add Goal\"].textFields[\"Goal Name\"]",".textFields[\"Goal Name\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.firstMatch
        goalNameTextField.tap()
    
        let textField = app.otherElements["Add Goal"].firstMatch.children(matching: .textField).element(boundBy: 1)
        textField.tap()
        textField.tap()
        
        let editGoalNavigationBar = app.navigationBars["Edit Goal"]
        let doneButton = editGoalNavigationBar.buttons["Done"]
        doneButton.tap()
        tablesQuery.otherElements["Progress"].firstMatch.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Edit"]/*[[".cells.buttons[\"Edit\"]",".buttons[\"Edit\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.firstMatch.tap()
        editGoalNavigationBar.buttons["Goals"].firstMatch.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.otherElements["Progress"]/*[[".cells.otherElements[\"Progress\"]",".otherElements[\"Progress\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.firstMatch.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Edit"]/*[[".cells.buttons[\"Edit\"]",".buttons[\"Edit\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.firstMatch.tap()
        goalNameTextField.tap()
        goalNameTextField.tap()
        textField.tap()
        textField.tap()
        doneButton.tap()
    }
    func testRemoveButton() {
        
        let app = XCUIApplication();
        let tablesQuery = app.tables
        if (tablesQuery.cells.count < 1){
            goalMakerHelper(app: app)
        }
        let oldCount = tablesQuery.cells.count;
        tablesQuery.otherElements["Progress"].firstMatch.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["trashIcon"]/*[[".cells.buttons[\"trashIcon\"]",".buttons[\"trashIcon\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.firstMatch.tap()
        assert(tablesQuery.cells.count < oldCount);        
    }
    
    func goalMakerHelper( app:XCUIApplication){
        
        app.navigationBars["Goals"].buttons["Add"].tap()
        //app.navigationBars.buttons["Add"].tap();
        
        let goalNameTextField = app/*@START_MENU_TOKEN@*/.textFields["Goal Name"]/*[[".otherElements.matching(identifier: \"Add Goal\").textFields[\"Goal Name\"]",".textFields[\"Goal Name\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        goalNameTextField.tap()
        goalNameTextField.typeText("tmp")
        
        let addGoalElement = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other)["Add Goal"]
        let textField = addGoalElement.children(matching: .textField).element(boundBy: 1)
        textField.tap()
        textField.typeText("200")
        
        let app2 = app
        app2/*@START_MENU_TOKEN@*/.buttons["Total"]/*[[".otherElements.matching(identifier: \"Add Goal\")",".segmentedControls.buttons[\"Total\"]",".buttons[\"Total\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        addGoalElement.tap()
        app2/*@START_MENU_TOKEN@*/.datePickers/*[[".otherElements.matching(identifier: \"Add Goal\").datePickers",".datePickers"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.pickerWheels["2018"].tap()
        app2/*@START_MENU_TOKEN@*/.navigationBars["Add Goal"]/*[[".otherElements.matching(identifier: \"Add Goal\").navigationBars[\"Add Goal\"]",".navigationBars[\"Add Goal\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.buttons["Done"].tap()
        
    }
}
