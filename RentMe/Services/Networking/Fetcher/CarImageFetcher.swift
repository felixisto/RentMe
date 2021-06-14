//
//  CarImageFetcher.swift
//  RentMe
//
//  Created by Kristiyan Butev on 12.06.21.
//

import Foundation
import Combine
import Resolver
import UIKit

/*
 * Encapsulates networking logic for pulling car info from the server.
 */
protocol CarImageFetcher {
    func fetch(withURL url: String) -> AnyPublisher<UIImage, Error>
}

/*
 * Standard implementation for CarImageFetcher.
 */
class CarImageFetcherImpl: CarImageFetcher {
    @Injected var urlSession: NetworkSession
    @Injected var requestBuilder: CarImageRequestBuilder
    
    func fetch(withURL url: String) -> AnyPublisher<UIImage, Error> {
        let session = self.urlSession
        
        do {
            let request = try self.requestBuilder.build(withURL: url)
            
            return session.dataTaskPublisher(forRequest: request).tryMap { (data: Data, response: URLResponse) -> UIImage in
                guard let image = UIImage(data: data) else {
                    throw ParserError.generic("Invalid image data")
                }
                
                return image
            }.mapError { (error) -> Error in
                error
            }.eraseToAnyPublisher()
        } catch {
            return Future { promise in
                promise(.failure(error))
            }.eraseToAnyPublisher()
        }
    }
}
