//
//  TestCarInfoManager.swift
//  RentMeTests
//
//  Created by Kristiyan Butev on 14.06.21.
//

import XCTest
import Combine
@testable import RentMe

class TestCarInfoManager: XCTestCase {
    var fetcherMockAlwaysSuccess: NetworkingFetchPublisherCallback {
        return {
            return Future { promise in
                promise(.success([]))
            }.eraseToAnyPublisher()
        }
    }
    
    var fetcherMock: NetworkingFetchPublisherCallback?
    
    override func setUpWithError() throws {
        fetcherMock = fetcherMockAlwaysSuccess
    }
    
    func testRefreshSuccess() throws {
        let manager = MockCarInfoManagerImpl()
        manager.fetcher = self
        
        let mockData: [AnyHashable] = [CarInfoJSONSamples().data1]
        
        self.fetcherMock = {
            return Future { promise in
                promise(.success(mockData))
            }.eraseToAnyPublisher()
        }
        
        let fetchExpectation = expectation(description: "onFetched must be called")
        
        manager.onFetchedCallback = { (json) in
            XCTAssert(mockData == json)
            fetchExpectation.fulfill()
        }
        
        manager.refresh()
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testRefreshFailure() throws {
        let manager = MockCarInfoManagerImpl()
        manager.fetcher = self
        
        let mockError = GenericError.unknown("test")
        
        self.fetcherMock = {
            return Future { promise in
                promise(.failure(mockError))
            }.eraseToAnyPublisher()
        }
        
        let fetchExpectation = expectation(description: "onFetched must be called")
        
        manager.onFetchFailureCallback = { (error) in
            XCTAssert(error as? GenericError != nil)
            fetchExpectation.fulfill()
        }
        
        manager.refresh()
        
        waitForExpectations(timeout: 1, handler: nil)
    }
}

extension TestCarInfoManager: CarInfoFetcher {
    func fetch() -> AnyPublisher<[AnyHashable], Error> {
        let callback = fetcherMock ?? fetcherMockAlwaysSuccess
        return callback()
    }
}
