//
//  PrimaryView.swift
//  RentMe
//
//  Created by Kristiyan Butev on 11.06.21.
//

import SwiftUI

enum PrimaryViewTabID: Int, Identifiable {
    var id: Int {
        return self.rawValue
    }
    
    case map = 0
    case list = 1
}

struct PrimaryView: View {
    var viewModel: PrimaryViewModel
    
    @State var selectedTab: PrimaryViewTabID
    
    var body: some View {
        TabView(selection: $selectedTab) {
            VStack {
                CarMapView(viewModel: viewModel.mapViewModel)
            }.tabItem {
                Label("Map", systemImage: "map")
            }.tag(PrimaryViewTabID.map)
            
            VStack {
                CarListView(viewModel: viewModel.listViewModel)
            }.tabItem {
                Label("List", systemImage: "list.dash")
            }.tag(PrimaryViewTabID.list)
        }
        .onAppear {
            if selectedTab == PrimaryViewTabID.map {
                viewModel.mapViewModel.refresh()
            } else {
                viewModel.listViewModel.refresh()
            }
        }.id(selectedTab)
    }
}
