//
//  NetworkSession.swift
//  RentMe
//
//  Created by Kristiyan Butev on 14.06.21.
//

import Foundation
import Combine

/*
 * This exists only to make testing less painful.
 */
protocol NetworkSession: class {
    func dataTaskPublisher(forURL url: URL) -> AnyPublisher<URLSession.DataTaskPublisher.Output, URLSession.DataTaskPublisher.Failure>
    func dataTaskPublisher(forRequest request: URLRequest) -> AnyPublisher<URLSession.DataTaskPublisher.Output, URLSession.DataTaskPublisher.Failure>
}

extension URLSession: NetworkSession {
    func dataTaskPublisher(forURL url: URL) -> AnyPublisher<URLSession.DataTaskPublisher.Output, URLSession.DataTaskPublisher.Failure> {
        return dataTaskPublisher(for: url).eraseToAnyPublisher()
    }
    
    func dataTaskPublisher(forRequest request: URLRequest) -> AnyPublisher<URLSession.DataTaskPublisher.Output, URLSession.DataTaskPublisher.Failure> {
        return dataTaskPublisher(for: request).eraseToAnyPublisher()
    }
}
