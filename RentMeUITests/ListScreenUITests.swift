//
//  ListScreenUITests.swift
//  RentMeUITests
//
//  Created by Kristiyan Butev on 14.06.21.
//

import XCTest

class ListScreenUITests: XCTestCase {
    let app = XCUIApplication()
    let doesNotExistPredicate = NSPredicate(format: "exists == FALSE")
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        
        app.launchArguments += ["UI_TESTING"]
        app.launchArguments += ["LAUNCH_ON_LIST"]
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testSwitchToMapAndBack() throws {
        app.launchArguments += ["TEST_DUMMY_CAR_INFO"]
        app.launch()
        
        XCTAssert(switchToMap())
        
        XCTAssert(app.otherElements["Map"].waitForExistence(timeout: 5))
        
        XCTAssert(switchToList())
        
        XCTAssert(app.scrollViews.firstMatch.waitForExistence(timeout: 1))
    }
    
    func testOpenRentAndCloseItem() throws {
        app.launchArguments += ["TEST_DUMMY_CAR_INFO"]
        app.launch()
        
        XCTAssert(app.scrollViews.firstMatch.waitForExistence(timeout: 5))
        
        let scrollViewsQuery = app.scrollViews
        scrollViewsQuery.otherElements.staticTexts.firstMatch.tap()
        
        // Click on the rent button
        let rentButton = scrollViewsQuery.otherElements.staticTexts["Rent"]
        XCTAssert(rentButton.waitForExistence(timeout: 5))
        rentButton.tap()
        
        // Dismiss the alert
        app.alerts["Demo app."].scrollViews.otherElements.buttons["OK"].tap()
        
        // Close preview
        let closeButton = scrollViewsQuery.otherElements.images["ClosePreviewButton"]
        XCTAssert(closeButton.waitForExistence(timeout: 5))
        closeButton.tap()
        let _ = self.expectation(for: doesNotExistPredicate, evaluatedWith: closeButton, handler: nil)
        self.waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testOpenExpectedItem() throws {
        app.launchArguments += ["TEST_DUMMY_CAR_INFO"]
        app.launch()
        
        XCTAssert(app.scrollViews.firstMatch.waitForExistence(timeout: 5))
        
        let scrollViewsQuery = app.scrollViews
        let firstElement = scrollViewsQuery.otherElements.staticTexts.firstMatch
        let carName = firstElement.label
        
        // Preview car
        firstElement.tap()
        
        // Verify tapped car equals displayed car name
        let headerName = scrollViewsQuery.otherElements.staticTexts["CarHeaderName"]
        XCTAssert(headerName.waitForExistence(timeout: 5))
        
        XCTAssert(carName == headerName.label, "Showing the incorrect car! Expected: \(carName)")
    }
    
    func testScrollUpAndDownOpenFirstItem() throws {
        app.launchArguments += ["TEST_DUMMY_CAR_INFO"]
        app.launch()
        
        XCTAssert(app.scrollViews.firstMatch.waitForExistence(timeout: 5))
        
        let scrollViewsQuery = app.scrollViews
        scrollViewsQuery.element.swipeUp()
        scrollViewsQuery.element.swipeDown()
        
        // Preview car
        scrollViewsQuery.otherElements.staticTexts.firstMatch.tap()
        
        // Click on the rent button
        let rentButton = scrollViewsQuery.otherElements.staticTexts["Rent"]
        XCTAssert(rentButton.waitForExistence(timeout: 5))
        rentButton.tap()
        
        // Dismiss the alert
        app.alerts["Demo app."].scrollViews.otherElements.buttons["OK"].tap()
    }
    
    func testOfflineMode() throws {
        app.launchArguments += ["ALWAYS_OFFLINE"]
        app.launch()
        
        XCTAssert(app.staticTexts["Connection issue"].waitForExistence(timeout: 5))
    }
}

// MARK: Utilities
extension ListScreenUITests {
    private func switchToList() -> Bool {
        let exists = app.buttons["List"].waitForExistence(timeout: 1)
        app.buttons["List"].tap()
        return exists
    }
    
    private func switchToMap() -> Bool {
        let exists = app.buttons["Map"].waitForExistence(timeout: 1)
        app.buttons["Map"].tap()
        return exists
    }
}
