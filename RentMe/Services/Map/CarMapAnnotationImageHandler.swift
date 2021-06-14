//
//  CarMapAnnotationImageHandler.swift
//  RentMe
//
//  Created by Kristiyan Butev on 13.06.21.
//

import Foundation
import UIKit
import Mapbox

protocol CarMapAnnotationImageHandler {
    func handle(mapView: MGLMapView, imageFor annotation: MGLAnnotation) -> MGLAnnotationImage?
}

class CarMapAnnotationImageHandlerImpl: CarMapAnnotationImageHandler {
    public static let KEY = "mapAnnotation"
    public static let REUSABLE_ID = KEY
    
    func handle(mapView: MGLMapView, imageFor annotation: MGLAnnotation) -> MGLAnnotationImage? {
        let imageKey = Self.KEY
        let reuseIdentifier = Self.REUSABLE_ID
        
        var view = mapView.dequeueReusableAnnotationImage(withIdentifier: reuseIdentifier)
        
        if view == nil {
            if let image = UIImage(named: imageKey) {
                view = MGLAnnotationImage(image: image, reuseIdentifier: reuseIdentifier)
            }
        }
        
        return view
    }
}
