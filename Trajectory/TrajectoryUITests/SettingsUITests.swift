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
        app.tables.staticTexts["Test Org With Code"].tap()
        
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
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Test Org With Code"]/*[[".cells.staticTexts[\"Test Org With Code\"]",".staticTexts[\"Test Org With Code\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let textField = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .textField).element(boundBy: 1)
        textField.tap()
        textField/*@START_MENU_TOKEN@*/.press(forDuration: 1.0);/*[[".tap()",".press(forDuration: 1.0);"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        app/*@START_MENU_TOKEN@*/.menuItems["Select All"]/*[[".menus.menuItems[\"Select All\"]",".menuItems[\"Select All\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.menuItems["Cut"]/*[[".menus.menuItems[\"Cut\"]",".menuItems[\"Cut\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        textField.typeText("uitest")
        
        let doneButton = app.navigationBars["Update Information"].buttons["Done"]
        doneButton.tap()
        textField.tap()
        textField.typeText("@gettrajectory.com")
        doneButton.tap()
    }
    
    func testUpdatePersonalInfoPhoneNumber() {
        app.tabBars.buttons["Settings"].tap()
        app.tables.staticTexts["Test Org With Code"].tap()
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
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Test Org With Code"]/*[[".cells.staticTexts[\"Test Org With Code\"]",".staticTexts[\"Test Org With Code\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["Update Information"].buttons["Cancel"].tap()
    }
    
    func testMyOrganizationsBackButton() {
        // Use recording to get started writing UI tests.
        let tabBarsQuery = app.tabBars
        tabBarsQuery.buttons["Settings"].tap()
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Organizations"]/*[[".cells.staticTexts[\"Organizations\"]",".staticTexts[\"Organizations\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery.cells.staticTexts["Add Organization"].tap()
        app.navigationBars["Add Organization"].buttons["Cancel"].tap()
        tablesQuery.buttons["Back"].tap()
    }
    
    func testAddOrganizationDoneButtonNoData() {
        // Use recording to get started writing UI tests.
        app.tabBars.buttons["Settings"].tap()
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Organizations"]/*[[".cells.staticTexts[\"Organizations\"]",".staticTexts[\"Organizations\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery.cells.staticTexts["Add Organization"].tap()
        
        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 1).children(matching: .other).element
        let textField = element.children(matching: .textField).element(boundBy: 0)
        textField.tap()
        
        let doneButton = app.navigationBars["Add Organization"].buttons["Done"]
        doneButton.tap()
        textField.tap()
        textField.typeText("111")
        
        let textField2 = element.children(matching: .textField).element(boundBy: 1)
        textField2.tap()
        textField2.typeText("000")
        doneButton.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Test Org With Code"]/*[[".cells.staticTexts[\"Test Org With Code\"]",".staticTexts[\"Test Org With Code\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeLeft()
    }
    
    func testUpdateMyBioDoneButton() {
        app.tabBars.buttons["Settings"].tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Bio"]/*[[".cells.staticTexts[\"Bio\"]",".staticTexts[\"Bio\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let textView = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .textView).element(boundBy: 2)
        textView.tap()
        textView/*@START_MENU_TOKEN@*/.press(forDuration: 1.1);/*[[".tap()",".press(forDuration: 1.1);"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        app/*@START_MENU_TOKEN@*/.menuItems["Select All"]/*[[".menus.menuItems[\"Select All\"]",".menuItems[\"Select All\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.menuItems["Cut"]/*[[".menus.menuItems[\"Cut\"]",".menuItems[\"Cut\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let doneButton = app.navigationBars["Bio"].buttons["Done"]
        doneButton.tap()
        textView.tap()
        textView.typeText("Bible reading")
        doneButton.tap()
    }
    
    func testUpdateMyBioCancelButton() {
        // Use recording to get started writing UI tests.
        let tabBarsQuery = app.tabBars
        tabBarsQuery.buttons["Settings"].tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Bio"]/*[[".cells.staticTexts[\"Bio\"]",".staticTexts[\"Bio\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["Bio"].buttons["Cancel"].tap()
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
        let tabBarsQuery = app.tabBars
        tabBarsQuery.buttons["Find"].tap()
        app.searchFields["Search for available mentors"].tap()
        app.searchFields["Search for available mentors"].typeText("UI Test")
        let profileimgElement = app.collectionViews.cells.otherElements.containing(.image, identifier:"profileImg").element
        profileimgElement.tap()
        app.buttons["Request Mentorship"].tap()
        app.sheets["Please confirm that you want to send this mentee request"].buttons["Confirm"].tap()
        
        tabBarsQuery.buttons["Settings"].tap()
        tabBarsQuery.buttons["Settings"].tap()
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Mentee Requests"]/*[[".cells.staticTexts[\"Mentee Requests\"]",".staticTexts[\"Mentee Requests\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["UI Test"]/*[[".cells.staticTexts[\"UI Test\"]",".staticTexts[\"UI Test\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Set End Date"].tap()
        app.buttons["Set Date and Accept"].tap()
        app.navigationBars["Mentee Requests"].buttons["Back"].tap()
        
        tabBarsQuery.buttons["Community"].tap()
        profileimgElement.tap()
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.swipeLeft()
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Cancel Mentorship"]/*[[".cells.buttons[\"Cancel Mentorship\"]",".buttons[\"Cancel Mentorship\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.sheets["Please confirm that you want to cancel this mentorship"].buttons["Confirm"].tap()
    }
    
    func testMyMenteeRequestsDeclineButton() {
        // Use recording to get started writing UI tests.
        let tabBarsQuery = app.tabBars
        tabBarsQuery.buttons["Find"].tap()
        app.searchFields["Search for available mentors"].tap()
        app.searchFields["Search for available mentors"].typeText("UI Test")
        let profileimgElement = app.collectionViews.cells.otherElements.containing(.image, identifier:"profileImg").element
        profileimgElement.tap()
        app.buttons["Request Mentorship"].tap()
        app.sheets["Please confirm that you want to send this mentee request"].buttons["Confirm"].tap()
        
        tabBarsQuery.buttons["Settings"].tap()
        tabBarsQuery.buttons["Settings"].tap()
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Mentee Requests"]/*[[".cells.staticTexts[\"Mentee Requests\"]",".staticTexts[\"Mentee Requests\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["UI Test"]/*[[".cells.staticTexts[\"UI Test\"]",".staticTexts[\"UI Test\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Decline"].tap()
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
    
    func testWillingToMentorSwitch() {
        app.tabBars.buttons["Settings"].tap()
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Mentee Requests"]/*[[".cells.staticTexts[\"Mentee Requests\"]",".staticTexts[\"Mentee Requests\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeUp()
        let mentorSwitch = tablesQuery.switches["Willing to Mentor"]
        mentorSwitch.tap()
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
