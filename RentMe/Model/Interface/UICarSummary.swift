//
//  UICarSummary.swift
//  RentMe
//
//  Created by Kristiyan Butev on 12.06.21.
//

import Foundation
import UIKit

/*
 * Interface friendly model, containing basic description of a car.
 */
struct UICarSummary: Identifiable {
    var id: String = "id"
    var name: String = "unknown"
    
    var make: String = ""
    var series: String = ""
    
    var latitude: Double = 0
    var longitude: Double = 0
    
    var carImageURL: String?
    var carImage: UIImage?
}
