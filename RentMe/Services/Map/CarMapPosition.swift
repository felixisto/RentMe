//
//  CarMapPosition.swift
//  RentMe
//
//  Created by Kristiyan Butev on 13.06.21.
//

import Foundation
import CoreLocation

struct CarMapPosition {
    var lat: Double
    var lon: Double
    
    var asCLLocation: CLLocationCoordinate2D {
        CLLocationCoordinate2DMake(lat, lon)
    }
    
    init() {
        self.lat = 0
        self.lon = 0
    }
    
    init(lat: Double, lon: Double) {
        self.lat = lat.clamp(CarMapConstraints.MIN_LATITUDE, CarMapConstraints.MAX_LATITUDE)
        self.lon = lon.clamp(CarMapConstraints.MIN_LONGTITUDE, CarMapConstraints.MAX_LONGTITUDE)
    }
    
    init(point: CLLocationCoordinate2D) {
        self.init(lat: Double(point.latitude), lon: Double(point.longitude))
    }
}
