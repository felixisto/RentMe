//
//  CarsRepository.swift
//  RentMe
//
//  Created by Kristiyan Butev on 11.06.21.
//

import Foundation
import Combine

/*
 * Describes a component that manages car info data.
 */
protocol CarsRepository: class {
    var cars: [CarInfo] { get }
    
    func save(newData data: [CarInfo])
}

/*
 * Standard implementation of CarsRepository.
 *
 * Note: Always publishes data on main thread.
 */
class CarsRepositoryImpl: CarsRepository {
    @Published var cars: [CarInfo] = []
    
    private let queue = DispatchQueue.main
    
    var carsPublisher: Published<[CarInfo]>.Publisher {
        return $cars
    }
    
    func save(newData data: [CarInfo]) {
        weak var weakSelf = self
        
        // Update safely on the main queue
        queue.async {
            weakSelf?.cars = data
        }
    }
}
