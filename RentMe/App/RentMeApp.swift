//
//  RentMeApp.swift
//  RentMe
//
//  Created by Kristiyan Butev on 11.06.21.
//

import SwiftUI

@main
struct RentMeApp: App {
    let components = RentMeComponents()
    
    var body: some Scene {
        WindowGroup {
            PrimaryView(viewModel: PrimaryViewModel(mapViewModel: CarMapViewModel(), listViewModel: CarListViewModel()),
                        selectedTab: components.defaultSelectedTab)
        }
    }
}
