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
    
    func testEmailRegistration() {
        let num = Int(arc4random_uniform(500000)) + 1000
        let email: String = "uitestnumber\(num)@gettrajectory.com"
        
        let emailTextField = app.textFields["Email"]
        emailTextField.tap()
        emailTextField.typeText(email)
        app.buttons["Continue"].tap()
        
        let passwordSecureTextField = app.secureTextFields["Password"]
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText("asdlkfjsdlkfj")
        app.otherElements.containing(.navigationBar, identifier:"Create A Password").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.tap()
        app.buttons["Create Account"].tap()
        
        let pleaseEnterYourNameTextField = app.textFields["Please enter your name"]
        pleaseEnterYourNameTextField.tap()
        pleaseEnterYourNameTextField.typeText("name name")
        
        let element = app.otherElements.containing(.navigationBar, identifier:"Profile Setup").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        element.tap()
        
        let nextButton = app.buttons["Next"]
        //nextButton.tap()
        
        let phonenumberTextField = app/*@START_MENU_TOKEN@*/.textFields["phoneNumber"]/*[[".textFields[\"Phone Number\"]",".textFields[\"phoneNumber\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        phonenumberTextField.tap()
        phonenumberTextField.typeText("3333333333")
        element.tap()
        nextButton.tap()
        
        let element2 = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        let textView = element2.children(matching: .textView).element(boundBy: 0)
        textView.tap()
        textView.typeText("Hobbies")
        
        let textView2 = element2.children(matching: .textView).element(boundBy: 1)
        textView2.tap()
        textView2.tap()
        textView2.typeText("Interests")
        nextButton.tap()
        
        let textField = element2.children(matching: .textField).element
        textField.tap()
        textField.typeText("Denomination")
        
        let textView3 = element2.children(matching: .textView).element
        textView3.tap()
        textView3.tap()
        textView3.typeText("Goals")
        app.buttons["Finish"].tap()
        
        
    }
    
    func testNextAndBackButtons() {
        let num = Int(arc4random_uniform(500000)) + 1000
        let email: String = "uitestnumber\(num)@gettrajectory.com"
        
        let emailTextField = app.textFields["Email"]
        emailTextField.tap()
        emailTextField.typeText(email)
        app.buttons["Continue"].tap()
        
        let passwordSecureTextField = app.secureTextFields["Password"]
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText("password")
        app.buttons["Create Account"].tap()
        
        let pleaseEnterYourNameTextField = app.textFields["Please enter your name"]
        pleaseEnterYourNameTextField.tap()
        pleaseEnterYourNameTextField.typeText("Tester")
        
        let nextButton = app.buttons["Next"]
        nextButton.tap()
        
        let phonenumberTextField = app/*@START_MENU_TOKEN@*/.textFields["phoneNumber"]/*[[".textFields[\"Phone Number\"]",".textFields[\"phoneNumber\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        phonenumberTextField.tap()
        phonenumberTextField.typeText("888-888-8888")
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
        profileSetupNavigationBarsQuery.buttons["Phone"].tap()
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
