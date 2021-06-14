//
//  CarMapView.swift
//  RentMe
//
//  Created by Kristiyan Butev on 11.06.21.
//

import SwiftUI

struct CarMapView: View {
    @StateObject var viewModel: CarMapViewModel
    
    @State private var selectedInfo: UICarInfo?
    
    var body: some View {
        if viewModel.isContentsLoaded {
            if !viewModel.carsInfo.isEmpty {
                loadedContents
            } else {
                noDataContents
            }
        } else {
            loadingContents
        }
    }
    
    var loadedContents: some View {
        VStack(alignment: .leading, spacing: 0) {
            RentCarHeaderView()
            
            ZStack(alignment: .top) {
                BoxMapView(viewModel: viewModel.mapViewModel)
                
                selectionHeader
            }
        }
        .sheet(item: $selectedInfo) { info in
            CarPreviewView(selectedInfo: $selectedInfo, viewModel: CarPreviewViewModel(carInfo: info))
        }
    }
    
    var selectionHeader: some View {
        GeometryReader { geo in
            VStack(alignment: .leading, spacing: 0) {
                if let selectedCar = viewModel.selectedCarInfo {
                    CarListItem(viewModel: CarListItemViewModel(info: selectedCar))
                        .frame(width: geo.size.width, height: 96)
                        .background(UIConstants.MAP_SELECTION_BACKGROUND_COLOR)
                        .onTapGesture {
                            selectedInfo = viewModel.selectedCarInfo
                        }
                }
                
                if !viewModel.isConnectedToInternet {
                    InternetConnectionErrorView().animation(.linear)
                }
                
                Spacer()
            }.frame(width: geo.size.width, height: 128)
        }
        .accessibility(identifier: "SelectionHeader")
    }
    
    var noDataContents: some View {
        GenericErrorMessageView(message: viewModel.lastErrorMessage ?? "Unknown error")
            .background(UIConstants.MAP_BACKGROUND_COLOR)
    }
    
    var loadingContents: some View {
        GeometryReader { geo in
            ProgressView()
                .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
        }
        .frame(width: nil, height: nil, alignment: .center)
        .background(UIConstants.MAP_BACKGROUND_COLOR)
    }
}

struct CarMapView_Previews: PreviewProvider {
    static var previews: some View {
        CarMapView(viewModel: viewModel)
    }
    
    static var viewModel: CarMapViewModel {
        let vm = CarMapViewModel()
        vm.isContentsLoaded = true
        vm.carsInfo = RentMePreviewData().dummyUICarsInfo
        return vm
    }
}
