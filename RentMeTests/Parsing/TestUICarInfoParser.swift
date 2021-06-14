//
//  TestUICarInfoParser.swift
//  RentMeTests
//
//  Created by Kristiyan Butev on 14.06.21.
//

import XCTest
@testable import RentMe

class TestUICarInfoParser: XCTestCase {
    func testOrdinaryInfo() throws {
        let infoID = CarIdentifier(id: "1", name: "name")
        let info = CarInfo(identifier: infoID, position: CarInfoPosition(latitude: 1, longitude: 5))
        
        let parser = UICarInfoParserImpl()
        
        let result = parser.parse(info: info)
        XCTAssert(result.id == info.id)
        XCTAssert(result.name == info.identifier.name)
        XCTAssert(result.latitude == info.position.latitude)
        XCTAssert(result.longitude == info.position.longitude)
    }
}
