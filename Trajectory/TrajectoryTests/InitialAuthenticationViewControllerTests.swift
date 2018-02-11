//
//  AuthenticationTests.swift
//  TrajectoryTests
//
//  Created by Jeremy Bost on 2/7/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import XCTest

@testable import Trajectory

class MockAuthentication: AuthenticationService {
    var currentUID: String? = "test"
    
    var signedIn: Bool = true
    
    var providers: [String]?
    
    var authError: AuthenticationError?
    
    var signedInWithEmail: String?
    var signedInWithPassword: String?
    
    var fetchedProvidersForEmail: String?
    
    func fetchProviders(forEmail email: String, completion: @escaping ([String]?, AuthenticationError?) -> Void) {
        fetchedProvidersForEmail = email
        completion(providers, authError)
    }
    
    func signOut() -> Bool {
        return true
    }
    
    func signIn(withEmail email: String, password: String, completion: ((Error) -> Void)?) {
        signedInWithEmail = email
        signedInWithPassword = password
    }
    
    
}

class InitialAuthenticationViewControllerTests: XCTestCase {
    
    var controllerUnderTest: InitialAuthenticationViewController!
    var mockAuth: MockAuthentication!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        controllerUnderTest = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InitialAuthenticationViewController") as! InitialAuthenticationViewController
        
        mockAuth = MockAuthentication()
        controllerUnderTest.authService = mockAuth
        controllerUnderTest.loadView()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        controllerUnderTest = nil
        mockAuth = nil
    }
    
    func testCorrectEmailValidation() {
        let email = "test@test.com"
        
        XCTAssertTrue(controllerUnderTest.validateEmail(enteredEmail: email))
    }
    
    func testIncorrectEmailValidation() {
        XCTAssertFalse(controllerUnderTest.validateEmail(enteredEmail: ""))
        XCTAssertFalse(controllerUnderTest.validateEmail(enteredEmail: "test"))
        XCTAssertFalse(controllerUnderTest.validateEmail(enteredEmail: "test@"))
        XCTAssertFalse(controllerUnderTest.validateEmail(enteredEmail: "test@test"))
        XCTAssertFalse(controllerUnderTest.validateEmail(enteredEmail: "test.com"))
        XCTAssertFalse(controllerUnderTest.validateEmail(enteredEmail: "@."))
        XCTAssertFalse(controllerUnderTest.validateEmail(enteredEmail: "@test.com"))
        XCTAssertFalse(controllerUnderTest.validateEmail(enteredEmail: "@.com"))
        XCTAssertFalse(controllerUnderTest.validateEmail(enteredEmail: "@test"))
        XCTAssertFalse(controllerUnderTest.validateEmail(enteredEmail: "@test."))
        XCTAssertFalse(controllerUnderTest.validateEmail(enteredEmail: "test@test."))
    }
    
    func testEmailWithPasswordProvider() {
        let email = "test@test.com"
        mockAuth.providers = ["password"]
        controllerUnderTest.emailField.text = email
        controllerUnderTest.continueButtonPrimaryActionTriggered(self)
        XCTAssertEqual(mockAuth.fetchedProvidersForEmail, email)
        XCTAssert(controllerUnderTest.destinationVC is PasswordAuthenticationViewController)
    }
    
    func testEmailWithoutPasswordProvider() {
        let email = "test@test.com"
        mockAuth.providers = []
        controllerUnderTest.emailField.text = email
        controllerUnderTest.continueButtonPrimaryActionTriggered(self)
        XCTAssertEqual(mockAuth.fetchedProvidersForEmail, email)
        XCTAssert(controllerUnderTest.destinationVC is NewPasswordViewController)
    }
    
    func testInvalidEmail() {
        let email = "test@test"
        mockAuth.providers = []
        controllerUnderTest.emailField.text = email
        controllerUnderTest.continueButtonPrimaryActionTriggered(self)
        XCTAssertNil(controllerUnderTest.destinationVC)
    }
    
}
