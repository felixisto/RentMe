//
//  CarListViewModel.swift
//  RentMe
//
//  Created by Kristiyan Butev on 11.06.21.
//

import Foundation
import Combine
import Resolver

class CarListViewModel: ObservableObject {
    @Published var isContentsLoaded = false
    
    @Published var carsInfo: [UICarInfo] = []
    @Published var lastErrorMessage: String?
    @Published var isConnectedToInternet: Bool = true
    
    @Injected var manager: CarInfoManager
    @Injected var pullCarsInfo: CarsInfoInteractor
    @Injected var carInfoParser: UICarInfoParser
    @Injected var errorHandling: ErrorHandling
    @Injected var networkStatus: NetworkStatusChecker
    
    private var subscribers = Set<AnyCancellable>()
    
    init() {
        weak var weakSelf = self
        
        let parser = carInfoParser
        
        pullCarsInfo.publisher
            .dropFirst() // Ignore the initial value, its going to be refreshed anyways
            .map({ (source) -> [UICarInfo] in
                source.map { (info) -> UICarInfo in
                    parser.parse(info: info)
                }
            })
            .sink(receiveValue: { (result) in
                weakSelf?.carsInfo = result
                weakSelf?.lastErrorMessage = nil
                weakSelf?.isContentsLoaded = true
            }).store(in: &subscribers)
        
        manager.errorMessagePublisher.receive(on: DispatchQueue.main)
            .dropFirst()
            .sink { (lastErrorMessage) in
            weakSelf?.lastErrorMessage = lastErrorMessage
            weakSelf?.isContentsLoaded = true
        }.store(in: &subscribers)
        
        networkStatus.isConnectedPublisher.receive(on: DispatchQueue.main).assign(to: &$isConnectedToInternet)
        
        refresh()
    }
    
    func refresh() {
        // Update networking state
        networkStatus.refresh()
        
        // Pull new data
        self.manager.refresh()
    }
}
