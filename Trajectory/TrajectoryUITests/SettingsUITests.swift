//
//  SettingsUITests.swift
//  TrajectoryUITests
//
//  Created by Andrew Vogel on 2/11/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import XCTest

class SettingsUITests: XCTestCase {
    
    //var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        
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
    }
    
    func testUpdateNameDoneButton() {
        // Use recording to get started writing UI tests.
        let app = XCUIApplication()
        app.launch()
        app.tabBars.buttons["Settings"].tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Name"]/*[[".cells.staticTexts[\"Name\"]",".staticTexts[\"Name\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["Update Name"].buttons["Done"].tap()
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        //XCTAssertTrue(self.getTopViewController()?.title == "Settings")
        app.terminate()
    }
    
    func testUpdateNameCancelButton() {
        // Use recording to get started writing UI tests.
        let app = XCUIApplication()
        app.launch()
        app.tabBars.buttons["Settings"].tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Name"]/*[[".cells.staticTexts[\"Name\"]",".staticTexts[\"Name\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["Update Name"].buttons["Done"].tap()
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        //XCTAssertTrue(self.getTopViewController()?.title == "Settings")
        app.terminate()
    }
    
    func testUpdateEmailDoneButton() {
        // Use recording to get started writing UI tests.
        let app = XCUIApplication()
        app.launch()
        app.tabBars.buttons["Settings"].tap()
        app.tables.staticTexts["Email Address"].tap()
        app.navigationBars["Update Email Address"].buttons["Done"].tap()
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        //XCTAssertTrue(self.getTopViewController()?.title == "Settings")
        app.terminate()
    }
    
    func testUpdateEmailCancelButton() {
        // Use recording to get started writing UI tests.
        let app = XCUIApplication()
        app.launch()
        app.tabBars.buttons["Settings"].tap()
        app.tables.staticTexts["Email Address"].tap()
        app.navigationBars["Update Email Address"].buttons["Cancel"].tap()
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        //XCTAssertTrue(self.getTopViewController()?.title == "Settings")
        app.terminate()
    }
    
    func testUpdatePhoneNumberDoneButton() {
        // Use recording to get started writing UI tests.
        let app = XCUIApplication()
        app.launch()
        app.tabBars.buttons["Settings"].tap()
        app.tables.staticTexts["Phone Number"].tap()
        app.navigationBars["Update Phone Number"].buttons["Done"].tap()
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        //XCTAssertTrue(self.getTopViewController()?.title == "Settings")
        app.terminate()
    }
    
    func testUpdatePhoneNumberCancelButton() {
        // Use recording to get started writing UI tests.
        let app = XCUIApplication()
        app.launch()
        app.tabBars.buttons["Settings"].tap()
        app.tables.staticTexts["Phone Number"].tap()
        app.navigationBars["Update Phone Number"].buttons["Cancel"].tap()
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        //XCTAssertTrue(self.getTopViewController()?.title == "Settings")
        app.terminate()
    }
    
    func testMyOrganizationsBackButton() {
        // Use recording to get started writing UI tests.
        let app = XCUIApplication()
        app.launch()
        app.tabBars.buttons["Settings"].tap()
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["My Organizations"]/*[[".cells.staticTexts[\"My Organizations\"]",".staticTexts[\"My Organizations\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery.buttons["Back"].tap()
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        //XCTAssertTrue(self.getTopViewController()?.title == "Settings")
        app.terminate()
    }
    
    func testAddOrganizationDoneButtonNoData() {
        // Use recording to get started writing UI tests.
        let app = XCUIApplication()
        app.launch()
        app.tabBars.buttons["Settings"].tap()
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["My Organizations"]/*[[".cells.staticTexts[\"My Organizations\"]",".staticTexts[\"My Organizations\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Add Organization"]/*[[".cells.staticTexts[\"Add Organization\"]",".staticTexts[\"Add Organization\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["Add Organization"].buttons["Done"].tap()
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        //XCTAssertTrue(self.getTopViewController()?.title == "Settings")
        app.terminate()
    }
    
    func testAddOrganizationCancelButton() {
        // Use recording to get started writing UI tests.
        let app = XCUIApplication()
        app.launch()
        app.tabBars.buttons["Settings"].tap()
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["My Organizations"]/*[[".cells.staticTexts[\"My Organizations\"]",".staticTexts[\"My Organizations\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Add Organization"]/*[[".cells.staticTexts[\"Add Organization\"]",".staticTexts[\"Add Organization\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["Add Organization"].buttons["Cancel"].tap()
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        //XCTAssertTrue(self.getTopViewController()?.title == "Settings")
        app.terminate()
    }
}

extension XCTestCase {
    public func getTopViewController() -> UIViewController?{
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController{
                topController = presentedViewController
            }
            return topController
        }else{
            return nil
        }
    }
    
}
