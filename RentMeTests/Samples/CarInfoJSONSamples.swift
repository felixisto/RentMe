//
//  CarInfoJSONSamples.swift
//  RentMeTests
//
//  Created by Kristiyan Butev on 14.06.21.
//

import Foundation

class CarInfoJSONSamples {
    var data1: [String : AnyHashable]
        = ["id": "WMWSW31030T222518",
           "modelIdentifier": "mini",
           "modelName": "MINI",
           "name": "Vanessa",
           "make": "BMW",
           "group": "MINI",
           "color": "midnight_black",
           "series": "MINI",
           "fuelType": "D",
           "fuelLevel": 0.7,
           "transmission": "M",
           "licensePlate": "M-VO0259",
           "latitude": 48.134557,
           "longitude": 11.576921,
           "innerCleanliness": "REGULAR",
           "carImageUrl": "https://cdn.sixt.io/codingtask/images/mini.png"]
    
    var data2: [String : AnyHashable]
        = ["id": "WMWSU31070T077232",
           "modelIdentifier": "mini",
           "modelName": "MINI",
           "name": "Regine",
           "make": "BMW",
           "group": "MINI",
           "color": "midnight_black",
           "series": "MINI",
           "fuelType": "D",
           "fuelLevel": 0.55,
           "transmission": "M",
           "licensePlate": "M-VO0259",
           "latitude": 48.114988,
           "longitude": 11.598359,
           "innerCleanliness": "REGULAR",
           "carImageUrl": "https://cdn.sixt.io/codingtask/images/mini.png"]
    
    var emptyData: [String : AnyHashable]
        = ["id": "",
           "modelIdentifier": "",
           "modelName": "",
           "name": "",
           "make": "",
           "group": "",
           "color": "",
           "series": "",
           "fuelType": "",
           "fuelLevel": "",
           "transmission": "",
           "licensePlate": "",
           "latitude": "",
           "longitude": "",
           "innerCleanliness": "",
           "carImageUrl": ""]
    
    var invalidData: [String : AnyHashable]
        = ["id": 111111111,
           "modelIdentifier": "mini",
           "modelName": "MINI",
           "name": "Vanessa",
           "make": "BMW",
           "group": "MINI",
           "color": "midnight_black",
           "series": "MINI",
           "fuelType": "D",
           "fuelLevel": 0.7,
           "transmission": "M",
           "licensePlate": "M-VO0259",
           "latitude": 48.134557,
           "longitude": 11.576921,
           "innerCleanliness": "REGULAR",
           "carImageUrl": "https://cdn.sixt.io/codingtask/images/mini.png"]
}
