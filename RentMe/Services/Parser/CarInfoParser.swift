//
//  CarInfoParser.swift
//  RentMe
//
//  Created by Kristiyan Butev on 11.06.21.
//

import Foundation
import UIKit
import Resolver

protocol CarInfoParser {
    func parse(json: [AnyHashable: Any]) throws -> CarInfo
}

class CarInfoParserImpl: CarInfoParser {
    @Injected var colorParser: CarColorParser
    
    func parse(json: [AnyHashable: Any]) throws -> CarInfo {
        let api = NetworkingAPI.CarInfo()
        
        // Required
        guard let id = json[api.KEY_ID] as? String else {
            throw ParserError.generic("Invalid server response")
        }
        
        if id.isEmpty {
            throw ParserError.generic("Invalid server response")
        }
        
        guard let name = json[api.KEY_NAME] as? String else {
            throw ParserError.generic("Invalid server response")
        }
        
        guard let lat = json[api.KEY_LATITUDE] as? Double else {
            throw ParserError.generic("Invalid server response")
        }
        
        guard let lon = json[api.KEY_LONGTITUDE] as? Double else {
            throw ParserError.generic("Invalid server response")
        }
        
        let identifier = CarIdentifier(id: id, name: name)
        let position = CarInfoPosition(latitude: lat, longitude: lon)
        var result = CarInfo(identifier: identifier, position: position)
        
        // Optional
        result.carImageURL = json[api.KEY_IMAGE_URL] as? String
        result.details.group = json[api.KEY_GROUP] as? String
        result.details.modelIdentifier = json[api.KEY_MODEL_ID] as? String
        result.details.modelName = json[api.KEY_MODEL_NAME] as? String
        result.details.make = json[api.KEY_MAKE] as? String
        result.details.color = parseCarColor(from: json[api.KEY_COLOR] as? String)
        result.details.series = json[api.KEY_SERIES] as? String
        result.details.fuelType = json[api.KEY_FUEL_TYPE] as? String
        result.details.fuelLevel = json[api.KEY_FUEL_LEVEL] as? Double
        result.details.transmission = json[api.KEY_TRANSMISSION] as? String
        result.details.licensePlate = json[api.KEY_LICENSE_PLATE] as? String
        result.details.innerCleanliness = parseUserUnfriendlyString(json[api.KEY_INNER_CLEANLINESS] as? String)
        
        return result
    }
    
    func parseUserUnfriendlyString(_ string: String?) -> String? {
        guard let str = string else {
            return nil
        }
        
        return str.replacingOccurrences(of: "_", with: " ").lowercased()
    }
    
    func parseCarColor(from string: String?) -> UIColor? {
        guard let str = string else {
            return nil
        }
        
        return try? self.colorParser.parse(str)
    }
}
