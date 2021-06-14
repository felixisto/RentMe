//
//  CarInfo.swift
//  RentMe
//
//  Created by Kristiyan Butev on 11.06.21.
//

import Foundation
import UIKit

/*
 * Business logic model, containing detailed information about a car.
 */
struct CarInfo: Identifiable {
    var id: String {
        return identifier.id
    }
    
    var identifier: CarIdentifier
    var position: CarInfoPosition
    var details = CarInfoDetails()
    
    var carImageURL: String?
}

struct CarIdentifier: Identifiable {
    var id: String
    var name: String
}

struct CarInfoPosition {
    public static let zero = CarInfoPosition(latitude: 0, longitude: 0)
    
    var latitude: Double
    var longitude: Double
}

struct CarInfoDetails {
    var group: String?
    var modelIdentifier: String?
    var modelName: String?
    var make: String?
    var color: UIColor?
    var series: String?
    var fuelType: String?
    var fuelLevel: Double?
    var transmission: String?
    var licensePlate: String?
    
    var innerCleanliness: String?
}
