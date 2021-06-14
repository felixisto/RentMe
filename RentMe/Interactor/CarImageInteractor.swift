//
//  CarImageInteractor.swift
//  RentMe
//
//  Created by Kristiyan Butev on 12.06.21.
//

import Foundation
import Combine
import Resolver
import UIKit

/*
 * Pulls car image data from the repository.
 */
struct CarImageInteractor {
    @Injected var manager: CarImageCacheManager
    
    func image(withURL sourceURL: String?, id: String) -> AnyPublisher<UIImage, Error> {
        guard let url = sourceURL else {
            return Future { promise in
                promise(.success(manager.placeholderImage))
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
        }
        
        return manager.image(for: id, withURL: url)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func image(withSummary summary: UICarSummary) -> AnyPublisher<UIImage, Error> {
        return image(withURL: summary.carImageURL, id: summary.id)
    }
    
    func image(withInfo info: UICarInfo) -> AnyPublisher<UIImage, Error> {
        return image(withURL: info.carImageURL, id: info.id)
    }
}
