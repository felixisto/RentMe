//
//  CarsInfoParser.swift
//  RentMe
//
//  Created by Kristiyan Butev on 15.06.21.
//

import Foundation
import UIKit
import Resolver

protocol CarsInfoParser {
    func parse(json: [AnyHashable]) throws -> [CarInfo]
}

class CarsInfoParserImpl: CarsInfoParser {
    @Injected var parser: CarInfoParser
    
    func parse(json array: [AnyHashable]) throws -> [CarInfo] {
        var result = [CarInfo]()
        var identifiers = Set<String>()
        
        for item in array {
            guard let dict = item as? [AnyHashable: Any] else {
                throw ParserError.generic("Invalid JSON data")
            }
            
            let info = try parser.parse(json: dict)
            
            if identifiers.contains(info.id) {
                continue
            }
            
            result.append(info)
            identifiers.insert(info.id)
        }
        
        return result
    }
}
