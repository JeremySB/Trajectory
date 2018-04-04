//
//  SettingsUITests.swift
//  TrajectoryUITests
//
//  Created by Andrew Vogel on 2/11/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import XCTest

class SettingsUITests: XCTestCase {
    
    var app: XCUIApplication!
    
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
    
    func testUpdatePersonalInfoName() {
        app.tabBars.buttons["Settings"].tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Organization"]/*[[".cells.staticTexts[\"Organization\"]",".staticTexts[\"Organization\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let textField = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .textField).element(boundBy: 0)
        textField.tap()
        textField/*@START_MENU_TOKEN@*/.press(forDuration: 1.0);/*[[".tap()",".press(forDuration: 1.0);"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        app/*@START_MENU_TOKEN@*/.menuItems["Select All"]/*[[".menus.menuItems[\"Select All\"]",".menuItems[\"Select All\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.menuItems["Cut"]/*[[".menus.menuItems[\"Cut\"]",".menuItems[\"Cut\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let doneButton = app.navigationBars["Update Information"].buttons["Done"]
        doneButton.tap()
        textField.tap()
        textField.typeText("UI Test")
        doneButton.tap()
    }
    
    func testUpdatePersonalInfoEmail() {
        app.tabBars.buttons["Settings"].tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Organization"]/*[[".cells.staticTexts[\"Organization\"]",".staticTexts[\"Organization\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let textField = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .textField).element(boundBy: 1)
        textField.tap()
        textField/*@START_MENU_TOKEN@*/.press(forDuration: 1.0);/*[[".tap()",".press(forDuration: 1.0);"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        app/*@START_MENU_TOKEN@*/.menuItems["Select All"]/*[[".menus.menuItems[\"Select All\"]",".menuItems[\"Select All\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.menuItems["Cut"]/*[[".menus.menuItems[\"Cut\"]",".menuItems[\"Cut\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        textField.typeText("test")
        
        let doneButton = app.navigationBars["Update Information"].buttons["Done"]
        doneButton.tap()
        textField.tap()
        textField.typeText("@test.com")
        doneButton.tap()
    }
    
    func testUpdatePersonalInfoPhoneNumber() {
        app.tabBars.buttons["Settings"].tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Organization"]/*[[".cells.staticTexts[\"Organization\"]",".staticTexts[\"Organization\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let textField = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .textField).element(boundBy: 2)
        textField.tap()
        textField/*@START_MENU_TOKEN@*/.press(forDuration: 0.8);/*[[".tap()",".press(forDuration: 0.8);"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        app.menuItems["Select All"].tap()
        app/*@START_MENU_TOKEN@*/.menuItems["Cut"]/*[[".menus.menuItems[\"Cut\"]",".menuItems[\"Cut\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let doneButton = app.navigationBars["Update Information"].buttons["Done"]
        doneButton.tap()
        textField.tap()
        textField.typeText("6666666666")
        doneButton.tap()
    }
    
    func testUpdatePersonalInfoCancelButton() {
        // Use recording to get started writing UI tests.
        app.tabBars.buttons["Settings"].tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Organization"]/*[[".cells.staticTexts[\"Organization\"]",".staticTexts[\"Organization\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["Update Information"].buttons["Cancel"].tap()
    }
    
    func testMyOrganizationsBackButton() {
        // Use recording to get started writing UI tests.
        
        app.tabBars.buttons["Settings"].tap()
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["My Organizations"]/*[[".cells.staticTexts[\"My Organizations\"]",".staticTexts[\"My Organizations\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery.buttons["Back"].tap()
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        //XCTAssertTrue(self.getTopViewController()?.title == "Settings")
        
    }
    
    func testAddOrganizationDoneButtonNoData() {
        // Use recording to get started writing UI tests.
        
        
        app.tabBars.buttons["Settings"].tap()
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["My Organizations"]/*[[".cells.staticTexts[\"My Organizations\"]",".staticTexts[\"My Organizations\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Add Organization"]/*[[".cells.staticTexts[\"Add Organization\"]",".staticTexts[\"Add Organization\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["Add Organization"].buttons["Done"].tap()
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        //XCTAssertTrue(self.getTopViewController()?.title == "Settings")
        
    }
    
    func testAddOrganizationCancelButton() {
        // Use recording to get started writing UI tests.
        
        
        app.tabBars.buttons["Settings"].tap()
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["My Organizations"]/*[[".cells.staticTexts[\"My Organizations\"]",".staticTexts[\"My Organizations\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Add Organization"]/*[[".cells.staticTexts[\"Add Organization\"]",".staticTexts[\"Add Organization\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["Add Organization"].buttons["Cancel"].tap()
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // XCTAssertTrue(self.getTopViewController()?.title == "Settings")
        
    }
    
    func testUpdateMyBioDoneButton() {
        // Use recording to get started writing UI tests.
        
        
        app.tabBars.buttons["Settings"].tap()
        app.tables.staticTexts["My Bio"].tap()
        app.navigationBars["My Bio"].buttons["Done"].tap()
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        //XCTAssertTrue(self.getTopViewController()?.title == "Settings")
        
    }
    
    func testUpdateMyBioCancelButton() {
        // Use recording to get started writing UI tests.
        
        
        app.tabBars.buttons["Settings"].tap()
        app.tables.staticTexts["My Bio"].tap()
        app.navigationBars["My Bio"].buttons["Cancel"].tap()
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        //XCTAssertTrue(self.getTopViewController()?.title == "Settings")
        
    }
    
    func testMyMenteeRequestsBackButton() {
        // Use recording to get started writing UI tests.
        
        
        app.tabBars.buttons["Settings"].tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Mentee Requests"]/*[[".cells.staticTexts[\"Mentee Requests\"]",".staticTexts[\"Mentee Requests\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["Mentee Requests"].buttons["Back"].tap()
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        //XCTAssertTrue(self.getTopViewController()?.title == "Settings")
        
    }
    
    func testMyMenteeRequestsSetEndDateButtonAndSetDateAndAccept() {
        // Use recording to get started writing UI tests.
        
        
        app.tabBars.buttons["Settings"].tap()
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Mentee Requests"]/*[[".cells.staticTexts[\"Mentee Requests\"]",".staticTexts[\"Mentee Requests\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["First Last"]/*[[".cells.staticTexts[\"First Last\"]",".staticTexts[\"First Last\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Set End Date"].tap()
        
        let dateFormatter = DateFormatter()
        let today = Date()
        dateFormatter.dateFormat = "dd"
        let date = dateFormatter.string(from: today)
        
        app.datePickers.pickerWheels[date].swipeUp()
        app.buttons["Set Date and Accept"].tap()
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        //XCTAssertTrue(self.getTopViewController()?.title == "Settings")
        
    }
    
    func testMyMenteeRequestsSetEndDateButtonAndGoBack() {
        // Use recording to get started writing UI tests.
        
        
        app.tabBars.buttons["Settings"].tap()
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Mentee Requests"]/*[[".cells.staticTexts[\"Mentee Requests\"]",".staticTexts[\"Mentee Requests\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["First Last"]/*[[".cells.staticTexts[\"First Last\"]",".staticTexts[\"First Last\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Set End Date"].tap()
        app.navigationBars["Set Duration"].buttons["Mentee"].tap()
        app.navigationBars["Mentee"].buttons["Mentee Requests"].tap()
        app.navigationBars["Mentee Requests"].buttons["Back"].tap()
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        //XCTAssertTrue(self.getTopViewController()?.title == "Settings")
        
    }
    
    func testMyMenteeRequestsDeclineButton() {
        // Use recording to get started writing UI tests.
        
        
        app.tabBars.buttons["Settings"].tap()
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Mentee Requests"]/*[[".cells.staticTexts[\"Mentee Requests\"]",".staticTexts[\"Mentee Requests\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["First Last"]/*[[".cells.staticTexts[\"First Last\"]",".staticTexts[\"First Last\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Decline"].tap()
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        //XCTAssertTrue(self.getTopViewController()?.title == "Settings")
        
    }
    
    func testMyMenteeRequestsBackButtons() {
        
        
        
        app.tabBars.buttons["Settings"].tap()
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Mentee Requests"]/*[[".cells.staticTexts[\"Mentee Requests\"]",".staticTexts[\"Mentee Requests\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["First Last"]/*[[".cells.staticTexts[\"First Last\"]",".staticTexts[\"First Last\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Set End Date"].tap()
        app.navigationBars["Set Duration"].buttons["Mentee"].tap()
        app.navigationBars["Mentee"].buttons["Mentee Requests"].tap()
        app.navigationBars["Mentee Requests"].buttons["Back"].tap()
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        //XCTAssertTrue(self.getTopViewController()?.title == "Settings")
        
    }
    
    func testChangeImageFeatureWithCancel() {
        
        
        
        app.tabBars.buttons["Settings"].tap()
        app.tables/*@START_MENU_TOKEN@*/.buttons["profileImg"]/*[[".cells.buttons[\"profileImg\"]",".buttons[\"profileImg\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["Photos"].buttons["Cancel"].tap()
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        //XCTAssertTrue(self.getTopViewController()?.title == "Settings")
        
    }
    
    func testNotificaitonsSwitch() {
        
        
        app.tabBars.buttons["Settings"].tap()
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Mentee Requests"]/*[[".cells.staticTexts[\"Mentee Requests\"]",".staticTexts[\"Mentee Requests\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeUp()
        let notificationsSwitch = tablesQuery/*@START_MENU_TOKEN@*/.switches["Notifications"]/*[[".cells.switches[\"Notifications\"]",".switches[\"Notifications\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        notificationsSwitch.tap()
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        //XCTAssertTrue(self.getTopViewController()?.title == "Settings")
        
        
    }
    
    func testLogoutButton() {
        
        
        app.tabBars.buttons["Settings"].tap()
       // app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .table).element/*@START_MENU_TOKEN@*/.swipeRight()/*[[".swipeUp()",".swipeRight()"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .table).element.swipeUp()
        app.tables/*@START_MENU_TOKEN@*/.buttons["Logout"]/*[[".cells.buttons[\"Logout\"]",".buttons[\"Logout\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        //XCTAssertTrue(self.getTopViewController()?.title == "???")
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
