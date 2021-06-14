//
//  NetworkMocking.swift
//  RentMeTests
//
//  Created by Kristiyan Butev on 14.06.21.
//

import Foundation
import Combine
@testable import RentMe

typealias NetworkingFetchPublisherCallback = ()->AnyPublisher<[AnyHashable], Error>

class MockCarInfoManagerImpl: CarInfoManagerImpl {
    var onFetchedCallback: ([AnyHashable])->Void = { json in }
    var onFetchSuccessCallback: ()->Void = { }
    var onFetchFailureCallback: (Error)->Void = { error in }
    
    override init() {
        super.init()
        
        weak var weakSelf = self
        
        onFetchedCallback = { json in weakSelf?.superOnFetched(data: json) }
        onFetchSuccessCallback = { weakSelf?.superOnFetchSuccess() }
        onFetchFailureCallback = { error in weakSelf?.superOnFetch(error: error) }
    }
    
    override func onFetched(data json: [AnyHashable]) {
        onFetchedCallback(json)
    }
    
    func superOnFetched(data json: [AnyHashable]) {
        super.onFetched(data: json)
    }
    
    override func onFetchSuccess() {
        onFetchSuccessCallback()
    }
    
    func superOnFetchSuccess() {
        super.onFetchSuccess()
    }
    
    override func onFetch(error: Error) {
        onFetchFailureCallback(error)
    }
    
    func superOnFetch(error: Error) {
        super.onFetch(error: error)
    }
}
