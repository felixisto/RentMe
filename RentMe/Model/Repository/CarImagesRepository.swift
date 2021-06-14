//
//  CarImagesRepository.swift
//  RentMe
//
//  Created by Kristiyan Butev on 12.06.21.
//

import Foundation
import Combine
import UIKit

/*
 * Describes a component that manages car image data.
 */
protocol CarImagesRepository: class {
    var placeholderImage: UIImage { get }
    
    var numberOfCachedImages: Int { get }
    
    func image(for key: String) -> UIImage?
    
    func save(image: UIImage, forKey key: String)
    
    // Deletes specified amount of images.
    func purge(count: Int)
}

/*
 * Standard implementation of CarsRepository.
 *
 * Note: Not thread safe, should be used on main thread only.
 */
class CarImagesRepositoryImpl: CarImagesRepository {
    @Published var images: [String: UIImage] = [:]
    
    let placeholderImage: UIImage = UIImage(named: "carPlaceholder") ?? UIImage()
    
    var numberOfCachedImages: Int {
        images.count
    }
    
    private let queue = DispatchQueue.main
    
    func image(for key: String) -> UIImage? {
        return self.images[key]
    }
    
    func save(image: UIImage, forKey key: String) {
        weak var weakSelf = self
        
        queue.async {
            weakSelf?.images[key] = image
        }
    }
    
    func purge(count: Int) {
        var left = count
        
        while left > 0 {
            left -= 1
            
            if let firstKey = images.keys.first {
                images.removeValue(forKey: firstKey)
            } else {
                break
            }
        }
    }
}
