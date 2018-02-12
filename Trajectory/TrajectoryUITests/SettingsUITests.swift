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
    
    func testUpdateNameDone() {
        // Use recording to get started writing UI tests.
        let app = XCUIApplication()
        app.launch()
        app.tabBars.buttons["Settings"].tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Name"]/*[[".cells.staticTexts[\"Name\"]",".staticTexts[\"Name\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["Update Name"].buttons["Done"].tap()
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        print("OUTPUT")
        print(self.getTopViewController()?.title)
        //XCTAssertTrue(self.getTopViewController()?.title == "Settings")
        app.terminate()
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
