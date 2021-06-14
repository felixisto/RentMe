//
//  UICarInfoParser.swift
//  RentMe
//
//  Created by Kristiyan Butev on 12.06.21.
//

import Foundation
import Resolver

protocol UICarInfoParser {
    func parse(info: CarInfo) -> UICarInfo
}

class UICarInfoParserImpl: UICarInfoParser {
    public static let UNKNOWN = "unknown"
    
    @Injected var imageRepository: CarImagesRepository
    
    func parse(info: CarInfo) -> UICarInfo {
        var result = UICarInfo()
        result.id = info.identifier.id
        result.name = info.identifier.name
        
        result.group = info.details.group ?? Self.UNKNOWN
        result.modelIdentifier = info.details.modelIdentifier ?? Self.UNKNOWN
        result.modelName = info.details.modelName ?? Self.UNKNOWN
        result.make = info.details.make ?? Self.UNKNOWN
        result.color = info.details.color
        result.series = info.details.series ?? Self.UNKNOWN
        result.fuelType = info.details.fuelType ?? Self.UNKNOWN
        
        if let fuel = info.details.fuelLevel {
            result.fuelLevel = "\(fuel)"
        }
        
        if let transmission = info.details.transmission {
            result.transmission = "\(transmission)"
        }
        
        result.licensePlate = info.details.licensePlate ?? Self.UNKNOWN
        result.innerCleanliness = info.details.innerCleanliness ?? Self.UNKNOWN
        
        result.latitude = info.position.latitude
        result.longitude = info.position.longitude
        
        result.carImageURL = info.carImageURL
        result.carImage = imageRepository.image(for: result.id) ?? imageRepository.placeholderImage
        
        return result
    }
}
