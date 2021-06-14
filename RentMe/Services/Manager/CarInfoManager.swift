//
//  CarInfoManager.swift
//  RentMe
//
//  Created by Kristiyan Butev on 11.06.21.
//

import Foundation
import Combine
import Resolver

/*
 * A component that fetches car info data from the server and stores it in a repository.
 */
protocol CarInfoManager: class {
    // Any errors encountered will be published here.
    var errorMessagePublisher: Published<String?>.Publisher { get }
    
    // Fetch new car data from the server.
    func refresh()
}

/*
 * Standard implementation of CarInfoManager.
 */
class CarInfoManagerImpl: CarInfoManager {
    @Published var lastErrorMessage: String?
    
    var errorMessagePublisher: Published<String?>.Publisher {
        $lastErrorMessage
    }
    
    @Injected var repository: CarsRepository
    @Injected var fetcher: CarInfoFetcher
    @Injected var carsInfoParser: CarsInfoParser
    @Injected var errorHandler: ErrorHandling
    
    private let queue = DispatchQueue(label: "com.rentme.CarInfoManager")
    private var subscriber: AnyCancellable?
    
    func refresh() {
        weak var weakSelf = self
        
        queue.async {
            weakSelf?.refreshNow()
        }
    }
    
    private func refreshNow() {
        if self.subscriber != nil {
            return
        }
        
        weak var weakSelf = self
        
        self.subscriber = fetcher.fetch().receive(on: queue).sink { (result) in
            switch result {
            case .finished:
                weakSelf?.onFetchSuccess()
                break
            case .failure(let error):
                weakSelf?.onFetch(error: error)
                break
            }
        } receiveValue: { (json) in
            weakSelf?.onFetched(data: json)
        }
    }
    
    func onFetched(data json: [AnyHashable]) {
        guard let carsInfo = try? carsInfoParser.parse(json: json) else {
            return
        }
        
        self.repository.save(newData: carsInfo)
    }
    
    func onFetchSuccess() {
        self.subscriber = nil
        self.lastErrorMessage = nil
    }
    
    func onFetch(error: Error) {
        self.subscriber = nil
        self.lastErrorMessage = errorHandler.userFriendlyMessage(forError: error)
        
        print("\(String(describing: Self.self)): fetch error \(error)!")
    }
}
