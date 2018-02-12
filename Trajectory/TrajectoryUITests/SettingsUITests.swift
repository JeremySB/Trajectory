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
    
    
    
    func testLogin() {
        // Use recording to get started writing UI tests.
        
        
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testUpdateName() {
        // Use recording to get started writing UI tests.
        /*let app = app2
        app.tabBars.buttons["Settings"].tap()
        let app2 = app
        app2?.tables/*@START_MENU_TOKEN@*/.staticTexts["Name"]/*[[".cells.staticTexts[\"Name\"]",".staticTexts[\"Name\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let textField = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .textField).element
        textField.tap()
        textField.tap()
        textField.swipeLeft()
        app2?/*@START_MENU_TOKEN@*/.menuItems["Cut"]/*[[".menus.menuItems[\"Cut\"]",".menuItems[\"Cut\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app2?/*@START_MENU_TOKEN@*/.keys["delete"].press(forDuration: 1.1);/*[[".keyboards.keys[\"delete\"]",".tap()",".press(forDuration: 1.1);",".keys[\"delete\"]"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/
        app2?/*@START_MENU_TOKEN@*/.buttons["shift"]/*[[".keyboards.buttons[\"shift\"]",".buttons[\"shift\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        textField.typeText("Sam")
        //XCTAssertTrue(textField.label == "Sam")
        app.navigationBars["Update Name"].buttons["Done"].tap()
        XCTAssertTrue(self.getTopViewController()?.title == "Settings")*/
        
        let app = XCUIApplication()
        app.launch()
        //let app = app2
        app.tabBars.buttons["Settings"].tap()

        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Name"]/*[[".cells.staticTexts[\"Name\"]",".staticTexts[\"Name\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        //let textField = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .textField).element
        //textField.tap()
        //textField/*@START_MENU_TOKEN@*/.press(forDuration: 1.2);/*[[".tap()",".press(forDuration: 1.2);"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        //app/*@START_MENU_TOKEN@*/.menuItems["Select All"]/*[[".menus.menuItems[\"Select All\"]",".menuItems[\"Select All\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        //let deleteKey = app/*@START_MENU_TOKEN@*/.keys["delete"]/*[[".keyboards.keys[\"delete\"]",".keys[\"delete\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        //deleteKey.tap()
        //deleteKey.tap()
        //app/*@START_MENU_TOKEN@*/.buttons["shift"]/*[[".keyboards.buttons[\"shift\"]",".buttons[\"shift\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        //textField.typeText("Samm")
        app.navigationBars["Update Name"].buttons["Done"].tap()

        app.terminate()
        //XCUIApplication().tables/*@START_MENU_TOKEN@*/.staticTexts["Name"]/*[[".cells.staticTexts[\"Name\"]",".staticTexts[\"Name\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        //XCUIApplication().tabBars.buttons["Settings"].tap()
        
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testUpdateEmail() {
        // Use recording to get started writing UI tests.
        
        
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testUpdatePhoneNumber() {
        // Use recording to get started writing UI tests.
        
        
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testUpdateMyBio() {
        // Use recording to get started writing UI tests.
        
        
        // Use XCTAssert and related functions to verify your tests produce the correct results.
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
