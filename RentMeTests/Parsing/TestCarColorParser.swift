//
//  TestCarColorParser.swift
//  RentMeTests
//
//  Created by Kristiyan Butev on 14.06.21.
//

import XCTest
@testable import RentMe

class TestCarColorParser: XCTestCase {
    func testParseValidData() throws {
        let colors = ["midnight_black", "hot_chocolate", "iced_chocolate", "schwarz"]
        
        let parser = CarColorParserImpl()
        
        do {
            for color in colors {
                let _ = try parser.parse(color)
            }
        } catch {
            XCTAssert(false, "Parsing should not fail, error: \(error)")
        }
    }
    
    func testParseEmptyData() throws {
        let parser = CarColorParserImpl()
        
        do {
            let _ = try parser.parse("")
            XCTAssert(false, "Parsing should fail for empty data")
        } catch {
            
        }
    }
    
    func testParseInvalidData() throws {
        let parser = CarColorParserImpl()
        
        do {
            let _ = try parser.parse("XXXX")
            XCTAssert(false, "Parsing should fail for invalid data")
        } catch {
            
        }
    }
}
