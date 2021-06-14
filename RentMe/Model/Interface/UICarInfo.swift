//
//  UICarInfo.swift
//  RentMe
//
//  Created by Kristiyan Butev on 12.06.21.
//

import Foundation
import UIKit

/*
 * Interface friendly model, containing basic description of a car.
 */
struct UICarInfo: Identifiable {
    var id: String = "id"
    var name: String = "unknown"
    
    var latitude: Double = 0
    var longitude: Double = 0
    
    var group: String = ""
    var modelIdentifier: String = ""
    var modelName: String = ""
    var make: String = ""
    var color: UIColor?
    var series: String = ""
    var fuelType: String = ""
    var fuelLevel: String = ""
    var transmission: String = ""
    var licensePlate: String = ""
    
    var innerCleanliness: String = ""
    
    var carImageURL: String?
    var carImage: UIImage?
}
