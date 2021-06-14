//
//  API.swift
//  RentMe
//
//  Created by Kristiyan Butev on 11.06.21.
//

import Foundation

/*
 * Source: https://cdn.sixt.io/codingtask/cars
 */
class NetworkingAPI {
    let FETCH_CARS_URL = "https://cdn.sixt.io/codingtask/cars"
    
    class CarInfo {
        let KEY_ID = "id"
        let KEY_MODEL_ID = "modelIdentifier"
        let KEY_MODEL_NAME = "modelName"
        let KEY_NAME = "name"
        let KEY_MAKE = "make"
        let KEY_GROUP = "group"
        let KEY_COLOR = "color"
        let KEY_SERIES = "series"
        let KEY_FUEL_TYPE = "fuelType"
        let KEY_FUEL_LEVEL = "fuelLevel"
        let KEY_TRANSMISSION = "transmission"
        let KEY_LICENSE_PLATE = "licensePlate"
        let KEY_LATITUDE = "latitude"
        let KEY_LONGTITUDE = "longitude"
        let KEY_INNER_CLEANLINESS = "innerCleanliness"
        let KEY_IMAGE_URL = "carImageUrl"
    }
}
