//
//  CarMap.swift
//  RentMe
//
//  Created by Kristiyan Butev on 11.06.21.
//

import Foundation
import CoreLocation

protocol CarMap: class {
    func approximatePosition(of positions: [CarMapPosition]) -> CarMapPosition
}

class CarMapImpl: CarMap {
    func approximatePosition(of positions: [CarMapPosition]) -> CarMapPosition {
        if positions.isEmpty {
            return CarMapConstraints.DEFAULT_POSITION
        }
        
        // Just return the first position
        let first = positions[0]
        return CarMapPosition(lat: first.lat, lon: first.lon)
    }
    
    func makeLocation(lat: Double, lon: Double) -> CLLocationCoordinate2D {
        return CLLocationCoordinate2DMake(lat, lon)
    }
}
