//
//  CarMapAnnotation.swift
//  RentMe
//
//  Created by Kristiyan Butev on 13.06.21.
//

import Foundation
import Mapbox

@objc class CarMapAnnotation: MGLPointAnnotation {
    let id: String
    
    init(id: String) {
        self.id = id
        super.init()
    }
    
    init(info: UICarInfo) {
        self.id = info.id
        super.init()
        self.coordinate = CarMapPosition(lat: info.latitude, lon: info.longitude).asCLLocation
        self.title = info.name
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
