//
//  CarInfoFetcher.swift
//  RentMe
//
//  Created by Kristiyan Butev on 11.06.21.
//

import Foundation
import Combine
import Resolver

/*
 * Encapsulates networking logic for pulling car info from the server.
 */
protocol CarInfoFetcher {
    func fetch() -> AnyPublisher<[AnyHashable], Error>
}

/*
 * Standard implementation for CarInfoFetcher.
 */
class CarInfoFetcherImpl: CarInfoFetcher {
    @Injected var urlSession: NetworkSession
    @Injected var requestBuilder: CarInfoRequestBuilder
    
    func fetch() -> AnyPublisher<[AnyHashable], Error> {
        let session = self.urlSession
        
        do {
            let request = try self.requestBuilder.build()
            
            return session.dataTaskPublisher(forRequest: request).tryMap { (data: Data, response: URLResponse) -> [AnyHashable] in
                let anyObject = try JSONSerialization.jsonObject(with: data, options: [])
                
                if let json = anyObject as? [AnyHashable] {
                    return json
                }
                
                throw ParserError.generic("Invalid JSON data")
            }.eraseToAnyPublisher()
        } catch {
            return Future { promise in
                promise(.failure(error))
            }.eraseToAnyPublisher()
        }
    }
}
