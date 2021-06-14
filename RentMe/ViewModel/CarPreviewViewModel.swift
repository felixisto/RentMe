//
//  CarPreviewViewModel.swift
//  RentMe
//
//  Created by Kristiyan Butev on 12.06.21.
//

import Foundation
import Combine
import Resolver

/*
 * Note that the model is simply a copy. Updating the repository will NOT update the model.
 */
class CarPreviewViewModel: ObservableObject {
    @Published var carInfo: UICarInfo
    @Published var isConnectedToInternet: Bool = true
    
    var isImageLoaded: Bool {
        return carInfo.carImage != nil
    }
    
    @Injected var carInfoParser: UICarInfoParser
    @Injected var pullCarImage: CarImageInteractor
    @Injected var networkStatus: NetworkStatusChecker
    
    private var networkStateSubscriber: AnyCancellable?
    private var fetchImageSubscriber: AnyCancellable?
    
    init(carInfo: UICarInfo) {
        self.carInfo = carInfo
        
        weak var weakSelf = self
        
        // Fetch image data when network comes back (if necessary)
        networkStateSubscriber = networkStatus.isConnectedPublisher
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { (value) in
                if value {
                    weakSelf?.fetchImageData()
                }
        })
        
        refresh()
    }
    
    func refresh() {
        // Update networking state
        networkStatus.refresh()
        
        fetchImageData()
    }
    
    func fetchImageData() {
        weak var weakSelf = self
        
        fetchImageSubscriber = pullCarImage.image(withInfo: carInfo)
            .sink { (result) in
                switch result {
                case .finished:
                    break
                case .failure(let error):
                    weakSelf?.handle(error: error)
                    break
                }
        } receiveValue: { (image) in
            weakSelf?.carInfo.carImage = image
        }
    }
    
    private func handle(error: Error) {
        print("\(String(describing: Self.self))| Image fetch error: \(error)!")
    }
}
