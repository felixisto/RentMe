//
//  MapScreenUITests.swift
//  RentMeUITests
//
//  Created by Kristiyan Butev on 14.06.21.
//

import XCTest

class MapScreenUITests: XCTestCase {
    let app = XCUIApplication()
    let doesNotExistPredicate = NSPredicate(format: "exists == FALSE")
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        
        app.launchArguments += ["UI_TESTING"]
        app.launchArguments += ["LAUNCH_ON_MAP"]
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testSwitchToListAndBack() throws {
        app.launch()
        
        XCTAssert(switchToList())
        
        XCTAssert(app.scrollViews.firstMatch.waitForExistence(timeout: 5))
        
        XCTAssert(switchToMap())
        
        XCTAssert(app.otherElements["Map"].waitForExistence(timeout: 1))
    }
    
    func testSelectAnnotation() throws {
        app.launchArguments += ["TEST_DUMMY_CAR_INFO"]
        app.launch()
        
        let map = app.otherElements["Map"]
        
        XCTAssert(map.waitForExistence(timeout: 5))
        
        // By default, nothing is selected
        let selectionInfo = app.staticTexts["SelectionHeader"].firstMatch
        let _ = self.expectation(for: doesNotExistPredicate, evaluatedWith: selectionInfo, handler: nil)
        self.waitForExpectations(timeout: 5.0, handler: nil)
        
        // Now select something
        let annotation = map.buttons["DUMMY_CAR_1"]
        annotation.tap()
        
        XCTAssert(selectionInfo.waitForExistence(timeout: 5))
    }
    
    func testOpenRentAndCloseItem() throws {
        app.launchArguments += ["TEST_DUMMY_CAR_INFO"]
        app.launch()
        
        let map = app.otherElements["Map"]
        
        XCTAssert(map.waitForExistence(timeout: 5))
        
        // Select something
        let selectionInfo = app.staticTexts["SelectionHeader"].firstMatch
        let annotation = map.buttons["DUMMY_CAR_1"]
        annotation.tap()
        
        XCTAssert(selectionInfo.waitForExistence(timeout: 5))
        
        selectionInfo.tap()
        
        // Click on the rent button
        let rentButton = app.scrollViews.otherElements.staticTexts["Rent"]
        XCTAssert(rentButton.waitForExistence(timeout: 5))
        rentButton.tap()
        
        // Dismiss the alert
        app.alerts["Demo app."].scrollViews.otherElements.buttons["OK"].tap()
        
        // Close preview
        let closeButton = app.scrollViews.otherElements.images["ClosePreviewButton"]
        XCTAssert(closeButton.waitForExistence(timeout: 5))
        
        closeButton.tap()
        
        let _ = self.expectation(for: doesNotExistPredicate, evaluatedWith: closeButton, handler: nil)
        self.waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testOpenExpectedItem() throws {
        app.launchArguments += ["TEST_DUMMY_CAR_INFO"]
        app.launch()
        
        let map = app.otherElements["Map"]
        
        XCTAssert(map.waitForExistence(timeout: 5))
        
        // Select something
        let selectionInfo = app.staticTexts["SelectionHeader"].firstMatch
        let annotation = map.buttons["DUMMY_CAR_1"]
        let carName = annotation.label
        annotation.tap()
        
        XCTAssert(selectionInfo.waitForExistence(timeout: 5))
        
        selectionInfo.tap()
        
        // Verify tapped car equals displayed car name
        let headerName = app.scrollViews.otherElements.staticTexts["CarHeaderName"]
        XCTAssert(headerName.waitForExistence(timeout: 5))
        
        XCTAssert(carName == headerName.label, "Showing the incorrect car! Expected: \(carName)")
    }
    
    func testOfflineMode() throws {
        app.launchArguments += ["ALWAYS_OFFLINE"]
        app.launch()
        
        XCTAssert(app.staticTexts["Connection issue"].waitForExistence(timeout: 5))
    }
}

// MARK: Utilities
extension MapScreenUITests {
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

