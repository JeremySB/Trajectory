//
//  FindScreensTests.swift
//  TrajectoryTests
//
//  Created by Andrew Vogel on 3/13/18.
//  Copyright © 2018 Recreational Hazard. All rights reserved.
//

import XCTest

@testable import Trajectory

class MockUserService: UserService {
    func getUser(uid: String, completion: @escaping (User?, UserServiceError?) -> Void) {
        
    }
    
    func getCurrentUser(_ completion: @escaping (User?, UserServiceError?) -> Void) {
        
    }
    
    func saveCurrentUser(_: User, completion: ((UserServiceError?) -> Void)?) {
        
    }
    
    func getAllUsers(completion: @escaping ([User]?, UserServiceError?) -> Void) {
        let testUserOne = User()
        let testUserTwo = User()
        let testUserThree = User()
        testUserOne.name = "Andrew V."
        testUserTwo.name = "Jeremy B."
        testUserThree.name = "Andy"
        completion([testUserOne, testUserTwo, testUserThree], nil)
    }
}

class FindScreensTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // --Tests for Find People View Controller--
    func testPeopleSearchForMatchesValidInput() {
        //Test setup
        var controllerUnderTest : FindPeopleViewController!
        controllerUnderTest = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FindPeople") as! FindPeopleViewController
        controllerUnderTest.loadView()
        //Test searchForMatches() function
        let testUserOne = User()
        let testUserTwo = User()
        let testUserThree = User()
        testUserOne.name = "Andrew V."
        testUserTwo.name = "Jeremy B."
        testUserThree.name = "Andy"
        controllerUnderTest.mentors = [testUserOne, testUserTwo, testUserThree]
        controllerUnderTest.searchForMatches(searchString: "Andrew")
        XCTAssertFalse(controllerUnderTest.searchResults.isEmpty)
    }
    
    func testPeopleSearchForMatchesInvalidInput() {
        //Test setup
        var controllerUnderTest : FindPeopleViewController!
        controllerUnderTest = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FindPeople") as! FindPeopleViewController
        controllerUnderTest.loadView()
        //Test searchForMatches() function
        let testUserOne = User()
        let testUserTwo = User()
        let testUserThree = User()
        testUserOne.name = "Andrew V."
        testUserTwo.name = "Jeremy B."
        testUserThree.name = "Andy"
        controllerUnderTest.mentors = [testUserOne, testUserTwo, testUserThree]
        controllerUnderTest.searchForMatches(searchString: "asdfdr")
        XCTAssert(controllerUnderTest.searchResults.isEmpty)
    }
    
    func testPeopleUpdateSearchResults() {
        //Test setup
        var controllerUnderTest : FindPeopleViewController!
        controllerUnderTest = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FindPeople") as! FindPeopleViewController
        controllerUnderTest.loadView()
        //Test updateSearchResults() function
        controllerUnderTest.userService = MockUserService()
        controllerUnderTest.searchBar.text = "Andrew"
        controllerUnderTest.updateSearchResults(for: controllerUnderTest.searchController)
        XCTAssert(controllerUnderTest.collectionView.numberOfItems(inSection: 0) != 0)
    }
    
    // --Tests for Find Organizations View Controller--
    func testOrganizationsSearchForMatchesValidInput() {
        //Test setup
        var controllerUnderTest : FindOrgsViewController!
        controllerUnderTest = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FindOrgs") as! FindOrgsViewController
        controllerUnderTest.loadView()
        //Test searchForMatches() function
        let testUserOne = User()
        let testUserTwo = User()
        let testUserThree = User()
        testUserOne.name = "Andrew V."
        testUserTwo.name = "Jeremy B."
        testUserThree.name = "Andy"
        let testOrgOne = Organization()
        let testOrgTwo = Organization()
        testOrgOne.name = "Test Organization 1"
        testOrgTwo.name = "Test Organization 2"
        controllerUnderTest.usersPerOrganization[testOrgOne] = [testUserOne, testUserTwo]
        controllerUnderTest.usersPerOrganization[testOrgTwo] = [testUserThree]
        controllerUnderTest.searchForMatches(searchString: "Andrew")
        XCTAssertFalse(controllerUnderTest.searchResults.isEmpty)
    }
    
    func testOrganizationsSearchForMatchesInvalidInput() {
        //Test setup
        var controllerUnderTest : FindOrgsViewController!
        controllerUnderTest = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FindOrgs") as! FindOrgsViewController
        controllerUnderTest.loadView()
        //Test searchForMatches() function
        let testUserOne = User()
        let testUserTwo = User()
        let testUserThree = User()
        testUserOne.name = "Andrew V."
        testUserTwo.name = "Jeremy B."
        testUserThree.name = "Andy"
        let testOrgOne = Organization()
        let testOrgTwo = Organization()
        testOrgOne.name = "Test Organization 1"
        testOrgTwo.name = "Test Organization 2"
        controllerUnderTest.usersPerOrganization[testOrgOne] = [testUserOne, testUserTwo]
        controllerUnderTest.usersPerOrganization[testOrgTwo] = [testUserThree]
        controllerUnderTest.searchForMatches(searchString: "dfsafd")
        XCTAssert(controllerUnderTest.searchResults.isEmpty)
    }
    
    
    func testOrganizationsUpdateSearchResults() {
        //Test setup
        var controllerUnderTest : FindOrgsViewController!
        controllerUnderTest = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FindOrgs") as! FindOrgsViewController
        controllerUnderTest.loadView()
        //Test updateSearchResults() function
        controllerUnderTest.userService = MockUserService()
        controllerUnderTest.searchBar.text = "Andrew"
        controllerUnderTest.updateSearchResults(for: controllerUnderTest.searchController)
        XCTAssert(controllerUnderTest.collectionView.numberOfItems(inSection: 0) != 0)
    }
    
}
