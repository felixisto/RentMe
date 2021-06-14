//
//  CarListView.swift
//  RentMe
//
//  Created by Kristiyan Butev on 11.06.21.
//

import SwiftUI

struct CarListView: View {
    @StateObject var viewModel: CarListViewModel
    
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
                ScrollView {
                    LazyVStack {
                        ForEach(viewModel.carsInfo) { info in
                            CarListItem(viewModel: CarListItemViewModel(info: info))
                                .onTapGesture {
                                    selectedInfo = info
                                }
                        }
                    }
                    .padding()
                }
                .background(UIConstants.RENT_LIST_BACKGROUND_COLOR)
                
                VStack(alignment: .leading, spacing: 0) {
                    if !viewModel.isConnectedToInternet {
                        InternetConnectionErrorView().animation(.linear)
                    }
                    
                    Spacer()
                }
            }
        }
        .sheet(item: $selectedInfo) { info in
            CarPreviewView(selectedInfo: $selectedInfo, viewModel: CarPreviewViewModel(carInfo: info))
        }
    }
    
    var noDataContents: some View {
        GenericErrorMessageView(message: viewModel.lastErrorMessage ?? "Unknown error")
            .background(UIConstants.RENT_LIST_BACKGROUND_COLOR)
    }
    
    var loadingContents: some View {
        GeometryReader { geo in
            ProgressView()
                .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
        }
        .frame(width: nil, height: nil, alignment: .center)
        .background(UIConstants.RENT_LIST_BACKGROUND_COLOR)
    }
}

struct CarListView_Previews: PreviewProvider {
    static var previews: some View {
        CarListView(viewModel: viewModel)
    }
    
    static var viewModel: CarListViewModel {
        let vm = CarListViewModel()
        vm.isContentsLoaded = true
        vm.carsInfo = RentMePreviewData().dummyUICarsInfo
        return vm
    }
}
