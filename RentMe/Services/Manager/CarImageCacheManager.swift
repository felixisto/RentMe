//
//  CarImageCacheManager.swift
//  RentMe
//
//  Created by Kristiyan Butev on 12.06.21.
//

import Foundation
import Combine
import Resolver
import UIKit

/*
 * A component that fetches car image data from the server and stores it in a repository.
 */
protocol CarImageCacheManager {
    var placeholderImage: UIImage { get }
    
    func image(for key: String, withURL url: String) -> AnyPublisher<UIImage, Error>
}

/*
 * Standard implementation of CarImageCacheManager.
 */
class CarImageCacheManagerImpl: CarImageCacheManager {
    public static let MAX_CACHE_SIZE = 20
    
    var placeholderImage: UIImage {
        return repository.placeholderImage
    }
    
    @Injected var repository: CarImagesRepository
    @Injected var fetcher: CarImageFetcher
    
    func image(for key: String, withURL url: String) -> AnyPublisher<UIImage, Error> {
        // If its already cached, skip network request
        if let image = repository.image(for: key) {
            return Future { promise in
                promise(.success(image))
            }.eraseToAnyPublisher()
        }
        
        print("\(String(describing: Self.self))| Fetching image for '\(key)'...'")
        
        purgeCacheIfNecessary()
        
        let repository = self.repository
        
        return fetcher.fetch(withURL: url).map { (img) -> UIImage in
            repository.save(image: img, forKey: key)
            return img
        }.receive(on: DispatchQueue.main).eraseToAnyPublisher()
    }
    
    private func purgeCacheIfNecessary() {
        let leftover = repository.numberOfCachedImages - Self.MAX_CACHE_SIZE
        
        if leftover > 0 {
            print("\(String(describing: Self.self))| Image cache is too big, purging \(leftover) images...'")
            repository.purge(count: leftover)
        }
    }
}
