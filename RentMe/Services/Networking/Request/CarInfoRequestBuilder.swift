//
//  CarInfoRequestBuilder.swift
//  RentMe
//
//  Created by Kristiyan Butev on 11.06.21.
//

import Foundation

/*
 * Builds car info fetch requests.
 */
protocol CarInfoRequestBuilder: class {
    func build() throws -> URLRequest
}

/*
 * Standard implementation for CarInfoRequestBuilder.
 */
class CarInfoRequestBuilderImpl: CarInfoRequestBuilder {
    func build() throws -> URLRequest {
        let stringURL = NetworkingAPI().FETCH_CARS_URL
        
        guard let url = URL(string: stringURL) else {
            throw GenericError.unknown("Bad API url")
        }
        
        return URLRequest(url: url)
    }
}
