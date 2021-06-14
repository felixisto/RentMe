//
//  CarListItem.swift
//  RentMe
//
//  Created by Kristiyan Butev on 11.06.21.
//

import SwiftUI

struct CarListItem: View {
    @ObservedObject var viewModel: CarListItemViewModel
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            Image(uiImage: viewModel.summary.carImage ?? UIImage())
                .resizable()
                .scaledToFit()
                .animation(.easeIn)
            
            VStack(alignment: .leading, spacing: 0) {
                Text(viewModel.summary.name)
                    .font(.system(size: UIConstants.RENT_PRIMARY_TEXT_SIZE))
                    .foregroundColor(UIConstants.RENT_PRIMARY_TEXT_COLOR)
                    .bold()
                
                Text(viewModel.summary.id)
                    .font(.system(size: UIConstants.RENT_SECONDARY_TEXT_SIZE))
                    .foregroundColor(UIConstants.RENT_SECONDARY_TEXT_COLOR)
                
                Text(viewModel.summary.make + " " + viewModel.summary.series)
                    .font(.system(size: UIConstants.RENT_TRIVIAL_TEXT_SIZE))
                    .foregroundColor(UIConstants.RENT_TRIVIAL_TEXT_COLOR)
            }
        }
    }
}

struct CarListItem_Previews: PreviewProvider {
    static var previews: some View {
        CarListItem(viewModel: viewModel).background(Rectangle().foregroundColor(UIConstants.RENT_LIST_BACKGROUND_COLOR))
    }
    
    static var viewModel: CarListItemViewModel {
        let carInfo = RentMePreviewData().dummyUICarsInfo.first!
        let vm = CarListItemViewModel(info: carInfo)
        return vm
    }
}
