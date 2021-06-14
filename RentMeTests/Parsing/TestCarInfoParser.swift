//
//  TestCarInfoParser.swift
//  RentMeTests
//
//  Created by Kristiyan Butev on 14.06.21.
//

import XCTest
@testable import RentMe

class TestCarInfoParser: XCTestCase {
    let samples = CarInfoJSONSamples()
    
    func testParsingValidData() throws {
        let data = samples.data1
        
        let parser = CarInfoParserImpl()
        
        do {
            let result = try parser.parse(json: data)
            XCTAssert(result.id == samples.data1["id"] as! String)
            XCTAssert(result.identifier.name == samples.data1["name"] as! String)
            XCTAssert(result.details.make == samples.data1["make"] as? String)
            XCTAssert(result.details.group == samples.data1["group"] as? String)
        } catch {
            XCTAssert(false, "Parser should not fail when parsing valid data, error: \(error)")
        }
    }
    
    func testParsingEmptyData() throws {
        let data = samples.emptyData
        
        let parser = CarInfoParserImpl()
        
        do {
            let _ = try parser.parse(json: data)
            XCTAssert(false, "Parser should fail when parsing invalid data") // id is invalid
        } catch {
            
        }
    }
    
    func testParsingInvalidData() throws {
        let data = samples.invalidData
        
        let parser = CarInfoParserImpl()
        
        do {
            let _ = try parser.parse(json: data)
            XCTAssert(false, "Parser should fail when parsing invalid data")
        } catch {
            
        }
    }
    
    func testParsingValidDataWithMultiples() throws {
        let data: [AnyHashable] = [samples.data1, samples.data2]
        
        let parser = CarsInfoParserImpl()
        
        do {
            let result = try parser.parse(json: data)
            XCTAssert(result.count == data.count)
        } catch {
            XCTAssert(false, "Parser should not fail when parsing valid data, error: \(error)")
        }
    }
    
    func testParsingValidDataWithDuplicates() throws {
        let data: [AnyHashable] = [samples.data2, samples.data1, samples.data2]
        
        let parser = CarsInfoParserImpl()
        
        do {
            let result = try parser.parse(json: data)
            XCTAssert(result.count == 2, "Should not contain duplicates")
        } catch {
            XCTAssert(false, "Parser should not fail when parsing valid data, error: \(error)")
        }
    }
}
