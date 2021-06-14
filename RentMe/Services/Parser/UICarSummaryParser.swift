//
//  UICarSummaryParser.swift
//  RentMe
//
//  Created by Kristiyan Butev on 12.06.21.
//

import Foundation
import Resolver

protocol UICarSummaryParser {
    func parse(info: UICarInfo) -> UICarSummary
}

class UICarSummaryParserImpl: UICarSummaryParser {
    @Injected var imageRepository: CarImagesRepository
    
    func parse(info: UICarInfo) -> UICarSummary {
        var result = UICarSummary()
        result.id = info.id
        result.name = info.name
        
        result.make = info.make
        result.series = info.series
        
        result.latitude = info.latitude
        result.longitude = info.longitude
        
        result.carImageURL = info.carImageURL
        result.carImage = imageRepository.image(for: result.id) ?? imageRepository.placeholderImage
        
        return result
    }
}
