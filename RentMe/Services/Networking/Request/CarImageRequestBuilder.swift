//
//  CarImageRequestBuilder.swift
//  RentMe
//
//  Created by Kristiyan Butev on 12.06.21.
//

import Foundation

/*
 * Builds car info fetch requests.
 */
protocol CarImageRequestBuilder: class {
    func build(withURL url: String) throws -> URLRequest
}

/*
 * Standard implementation for CarInfoRequestBuilder.
 */
class CarImageRequestBuilderImpl: CarImageRequestBuilder {
    func build(withURL url: String) throws -> URLRequest {
        guard let url = URL(string: url) else {
            throw GenericError.unknown("Bad url")
        }
        
        return URLRequest(url: url)
    }
}
