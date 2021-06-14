//
//  RentMeTesting.swift
//  RentMe
//
//  Created by Kristiyan Butev on 14.06.21.
//

import Foundation
import Combine
import Resolver

class RentMePreviewData {
    let dummyCars: [CarInfo] = {
        let basePosCoordinates = CarMapConstraints.DEFAULT_POSITION
        let basePos = CarInfoPosition(latitude: basePosCoordinates.lat, longitude: basePosCoordinates.lon)
        let offsetValue = 0.01
        var car1 = CarInfo(identifier: CarIdentifier(id: "00000001", name: "DUMMY_CAR_1"), position: basePos)
        car1.details.make = "BMW"
        car1.details.series = "MINI"
        car1.position.latitude += offsetValue
        car1.position.longitude += offsetValue
        var car2 = CarInfo(identifier: CarIdentifier(id: "00000002", name: "DUMMY_CAR_2"), position: basePos)
        car2.details.make = "Lada"
        car2.details.series = "MINI"
        car2.position.latitude -= offsetValue
        car2.position.longitude += offsetValue
        var car3 = CarInfo(identifier: CarIdentifier(id: "00000003", name: "DUMMY_CAR_3"), position: basePos)
        car3.details.make = "Cadilac"
        car3.details.series = "MINI"
        car3.position.latitude -= offsetValue
        car3.position.longitude -= offsetValue
        return [car1, car2, car3]
    }()
    
    var dummyUICarsInfo: [UICarInfo] {
        let parser = UICarInfoParserImpl()
        return dummyCars.map { (info) -> UICarInfo in
            parser.parse(info: info)
        }
    }
}

// MARK: Testing
extension RentMeComponents {
    func setupTestingEnvironment() {
        setupUITestingEnvironment()
    }
    
    func setupUITestingEnvironment() {
        if !Self.isUITesting() {
            return
        }
        
        if Self.isAlwaysOffline() {
            Resolver.register { NetworkStatusConstant(defaultValue: false) as NetworkStatusChecker }
            Resolver.register { TestingAlwaysOfflineSession() as NetworkSession }
        } else {
            Resolver.register { NetworkStatusConstant(defaultValue: true) as NetworkStatusChecker }
        }
        
        if Self.isTestingDummyCarInfo() {
            Resolver.register { TestingCarInfoManager() as CarInfoManager }
        }
        
        if Self.launchOnMapTab() {
            defaultSelectedTab = .map
        }
        
        if Self.launchOnListTab() {
            defaultSelectedTab = .list
        }
    }
    
    static func appArguments(contains string: String) -> Bool {
        return ProcessInfo.processInfo.arguments.contains(string)
    }
    
    static func isUITesting() -> Bool {
        return appArguments(contains: "UI_TESTING")
    }
    
    static func isAlwaysOffline() -> Bool {
        return appArguments(contains: "ALWAYS_OFFLINE")
    }
    
    static func launchOnMapTab() -> Bool {
        return appArguments(contains: "LAUNCH_ON_MAP")
    }
    
    static func launchOnListTab() -> Bool {
        return appArguments(contains: "LAUNCH_ON_LIST")
    }
    
    static func isTestingDummyCarInfo() -> Bool {
        return appArguments(contains: "TEST_DUMMY_CAR_INFO")
    }
}

class TestingAlwaysOfflineSession: NetworkSession {
    func dataTaskPublisher(forURL url: URL) -> AnyPublisher<URLSession.DataTaskPublisher.Output, URLSession.DataTaskPublisher.Failure> {
        return alwaysOffline()
    }
    
    func dataTaskPublisher(forRequest request: URLRequest) -> AnyPublisher<URLSession.DataTaskPublisher.Output, URLSession.DataTaskPublisher.Failure> {
        return alwaysOffline()
    }
    
    func alwaysOffline() -> AnyPublisher<URLSession.DataTaskPublisher.Output, URLSession.DataTaskPublisher.Failure> {
        return Future<URLSession.DataTaskPublisher.Output, URLSession.DataTaskPublisher.Failure> { promise in
            let error = URLError(.cannotConnectToHost)
            promise(.failure(error))
        }.eraseToAnyPublisher()
    }
}

class TestingCarInfoManager: CarInfoManagerImpl {
    let dummyData = RentMePreviewData().dummyCars
    
    override func onFetched(data json: [AnyHashable]) {
        self.repository.save(newData: dummyData)
    }
    
    override func onFetchSuccess() {
        self.repository.save(newData: dummyData)
    }
    
    override func onFetch(error: Error) {
        self.repository.save(newData: dummyData)
    }
}
