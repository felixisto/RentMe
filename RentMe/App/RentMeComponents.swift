//
//  RentMeComponents.swift
//  RentMe
//
//  Created by Kristiyan Butev on 11.06.21.
//

import Foundation
import Resolver

/*
 * Contains the services/dependencies of the app.
 */
class RentMeComponents {
    let urlSession: NetworkSession
    
    // Repositories
    let carsRepository = CarsRepositoryImpl()
    let carImagesRepository = CarImagesRepositoryImpl()
    
    // Manager
    lazy var carInfoManager = CarInfoManagerImpl()
    lazy var carImageCacheManager = CarImageCacheManagerImpl()
    
    // View
    var defaultSelectedTab: PrimaryViewTabID = PrimaryViewTabID.map
    
    init() {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        config.urlCache = nil
        config.waitsForConnectivity = false
        
        self.urlSession = URLSession(configuration: config)
        
        Resolver.register { self.urlSession as NetworkSession }
        
        // Repositories
        Resolver.register { self.carsRepository as CarsRepository }
        Resolver.register { self.carImagesRepository as CarImagesRepository }
        
        // Parsers
        Resolver.register { CarInfoParserImpl() as CarInfoParser }
        Resolver.register { CarsInfoParserImpl() as CarsInfoParser }
        Resolver.register { CarColorParserImpl() as CarColorParser }
        Resolver.register { UICarSummaryParserImpl() as UICarSummaryParser }
        Resolver.register { UICarInfoParserImpl() as UICarInfoParser }
        
        // Interactors/fetchers
        Resolver.register { CarInfoFetcherImpl() as CarInfoFetcher }
        Resolver.register { CarInfoRequestBuilderImpl() as CarInfoRequestBuilder }
        Resolver.register { CarImageFetcherImpl() as CarImageFetcher }
        Resolver.register { CarImageRequestBuilderImpl() as CarImageRequestBuilder }
        
        Resolver.register {
            CarsInfoInteractor(publisher: self.carsRepository.carsPublisher.eraseToAnyPublisher()) as CarsInfoInteractor
        }
        Resolver.register { CarImageInteractor() as CarImageInteractor }
        
        // Manager
        Resolver.register { self.carInfoManager as CarInfoManager }
        Resolver.register { self.carImageCacheManager as CarImageCacheManager }
        
        // Other
        Resolver.register { NetworkStatus() as NetworkStatusChecker }
        Resolver.register { CarMapImpl() as CarMap }
        Resolver.register { CarMapAnnotationImageHandlerImpl() as CarMapAnnotationImageHandler }
        Resolver.register { ErrorHandling() }
        
        // Testing
        setupTestingEnvironment()
    }
}
