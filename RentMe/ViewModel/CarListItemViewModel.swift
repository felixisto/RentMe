//
//  CarListItemViewModel.swift
//  RentMe
//
//  Created by Kristiyan Butev on 12.06.21.
//

import Foundation
import Combine
import Resolver

class CarListItemViewModel: ObservableObject {
    @Published var summary: UICarSummary
    
    @Injected var carSummaryParser: UICarSummaryParser
    @Injected var pullCarImage: CarImageInteractor
    @Injected var networkStatus: NetworkStatusChecker
    
    var isImageLoaded: Bool {
        return summary.carImage != nil
    }
    
    private var fetchImageSubscriber: AnyCancellable?
    
    init(info: UICarInfo) {
        self.summary = UICarSummary()
        self.summary = carSummaryParser.parse(info: info)
        
        fetchImageData()
    }
    
    init(summary: UICarSummary) {
        self.summary = summary
        
        refresh()
    }
    
    func refresh() {
        // Update networking state
        networkStatus.refresh()
        
        fetchImageData()
    }
    
    func fetchImageData() {
        weak var weakSelf = self
        
        fetchImageSubscriber = pullCarImage.image(withSummary: summary)
            .sink { (result) in
                switch result {
                case .finished:
                    break
                case .failure(let error):
                    weakSelf?.handle(error: error)
                    break
                }
        } receiveValue: { (image) in
            weakSelf?.summary.carImage = image
        }
    }
    
    private func handle(error: Error) {
        print("\(String(describing: Self.self))| Image fetch error: \(error)!")
    }
}
