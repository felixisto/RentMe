//
//  CarsInfoInteractor.swift
//  RentMe
//
//  Created by Kristiyan Butev on 12.06.21.
//

import Foundation
import Combine

/*
 * Pulls car info data from the repository.
 */
struct CarsInfoInteractor {
    var publisher: AnyPublisher<[CarInfo], Never>
    
    init(publisher: AnyPublisher<[CarInfo], Never>) {
        self.publisher = publisher.receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
