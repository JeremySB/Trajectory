//
//  RegistrationTests.swift
//  TrajectoryUITests
//
//  Created by Jeremy Bost on 2/15/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import XCTest

class RegistrationTests: XCTestCase {
        
    var app: XCUIApplication!
    var existsPred = NSPredicate(format: "exists == true")
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        app = XCUIApplication()
        app.launchArguments.append("uiTestingLoggedOut")
        app.launch()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        app.terminate()
    }
    
    func testtest() {
        
        
        
        
        
    }
    
    func testEmailRegistration() {
        let num = Int(arc4random_uniform(500000)) + 1000
        let email: String = "uitestnumber\(num)@gettrajectory.com"
        
        let emailTextField = app.textFields["emailField"]
        emailTextField.tap()
        emailTextField.typeText(email)
        app.buttons["continueButton"].tap()
        
        let passwordSecureTextField = app.secureTextFields["passwordField"]
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText("asdlkfjsdlkfj")
        app.buttons["createAccountButton"].tap()
        
        let pleaseEnterYourNameTextField = app.textFields["nameField"]
        pleaseEnterYourNameTextField.tap()
        pleaseEnterYourNameTextField.typeText("name name")
        
        app.buttons["nextButton"].tap()
        
        let phonenumberTextField = app/*@START_MENU_TOKEN@*/.textFields["phoneNumber"]/*[[".textFields[\"Phone Number\"]",".textFields[\"phoneNumber\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        phonenumberTextField.tap()
        phonenumberTextField.typeText("3333333333")
        app.buttons["nextButton"].tap()
        
        let hobbiesField = app.textViews["hobbiesField"]
        hobbiesField.tap()
        hobbiesField.typeText("Hobbies")
        
        let textView2 = app.textViews["interestsField"]
        textView2.tap()
        textView2.typeText("Interests")
        app.buttons["nextButton"].tap()
        
        
        let textField = app.textFields["denomField"]
        textField.tap()
        textField.typeText("Denomination")
        
        let textView3 = app.textViews["objectivesField"]
        textView3.tap()
        textView3.typeText("Goals")
        app.buttons["finishButton"].tap()
        
        

    }
    
    func testNextAndBackButtons() {
        let num = Int(arc4random_uniform(500000)) + 1000
        let email: String = "uitestnumber\(num)@gettrajectory.com"
        
        let emailTextField = app.textFields["Email Address"]
        emailTextField.tap()
        emailTextField.typeText(email)
        app.buttons["Continue"].tap()
        
        let passwordSecureTextField = app.secureTextFields["Password"]
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText("password")
        app.buttons["Create Account"].tap()
        
        let pleaseEnterYourNameTextField = app.textFields["  Name"]
        pleaseEnterYourNameTextField.tap()
        pleaseEnterYourNameTextField.typeText("UI Tester")
        
        let nextButton = app.buttons["Next"]
        nextButton.tap()
        
        let phonenumberTextField = app/*@START_MENU_TOKEN@*/.textFields["phoneNumber"]/*[[".textFields[\"Phone Number\"]",".textFields[\"phoneNumber\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        phonenumberTextField.tap()
        phonenumberTextField.typeText("8888888888")
        nextButton.tap()
        
        let element2 = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        let element = element2.children(matching: .other).element
        let textView = element.children(matching: .textView).element(boundBy: 0)
        textView.tap()
        textView.typeText("Test")
        element.tap()
        
        let textView2 = element.children(matching: .textView).element(boundBy: 1)
        textView2.tap()
        textView2.typeText("Test")
        nextButton.tap()
        
        let textField = element.children(matching: .textField).element
        textField.tap()
        textField.typeText("Test")
        
        let textView3 = element.children(matching: .textView).element
        textView3.tap()
        textView3.typeText("Test")
        
        let profileSetupNavigationBarsQuery = app.navigationBars.matching(identifier: "Profile Setup")
        profileSetupNavigationBarsQuery.buttons["Profile Setup"].tap()
        profileSetupNavigationBarsQuery.buttons["Profile Setup"].tap()
        app.navigationBars["Profile Setup"].buttons["Profile Setup"].tap()
        nextButton.tap()
        nextButton.tap()
        nextButton.tap()
        app.buttons["Finish"].tap()
        
        app.tabBars.buttons["Find"].tap()
        let searchForPeopleSearchField = app.searchFields["Search for people"]
        searchForPeopleSearchField.tap()
        searchForPeopleSearchField.typeText("Andrew")
    }
}
