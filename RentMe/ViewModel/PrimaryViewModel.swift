//
//  PrimaryViewModel.swift
//  RentMe
//
//  Created by Kristiyan Butev on 11.06.21.
//

import Foundation
import Combine

class PrimaryViewModel: ObservableObject {
    // Do not use state objects. We dont want to re-render this on change.
    let mapViewModel: CarMapViewModel
    let listViewModel: CarListViewModel
    
    init(mapViewModel: CarMapViewModel, listViewModel: CarListViewModel) {
        self.mapViewModel = mapViewModel
        self.listViewModel = listViewModel
    }
}
