//
//  CarMapConstraints.swift
//  RentMe
//
//  Created by Kristiyan Butev on 13.06.21.
//

import Foundation

class CarMapConstraints {
    public static let MAX_LATITUDE: Double = 90
    public static let MIN_LATITUDE: Double = -90
    public static let MAX_LONGTITUDE: Double = 90
    public static let MIN_LONGTITUDE: Double = -90
    
    public static let DEFAULT_POSITION = CarMapPosition(lat: 48.1548256, lon: 11.401753)
    public static let DEFAULT_ZOOM_LEVEL: Double = 10
}
