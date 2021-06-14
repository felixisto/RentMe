//
//  CarColorParser.swift
//  RentMe
//
//  Created by Kristiyan Butev on 11.06.21.
//

import Foundation
import UIKit

protocol CarColorParser {
    func parse(_ string: String) throws -> UIColor
}

class CarColorParserImpl: CarColorParser {
    func parse(_ string: String) throws -> UIColor {
        switch string {
        case "midnight_black":
            return UIColor(r: 0, g: 14, b: 56)
        case "hot_chocolate":
            return UIColor(r: 222, g: 180, b: 130)
        case "midnight_black_metal":
            return UIColor(r: 56, g: 14, b: 56)
        case "light_white":
            return UIColor(r: 255, g: 248, b: 220)
        case "iced_chocolate":
            return UIColor(r: 222, g: 184, b: 135)
        case "alpinweiss":
            return UIColor(r: 220, g: 220, b: 220)
        case "saphirschwarz":
            return UIColor(r: 230, g: 240, b: 240)
        case "iced_chocolate_metal":
            return UIColor(r: 205, g: 133, b: 63)
        case "schwarz":
            return UIColor.black
        default:
            throw ParserError.generic("unknown car color")
        }
    }
}
