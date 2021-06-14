//
//  CarInfoDetailsView.swift
//  RentMe
//
//  Created by Kristiyan Butev on 12.06.21.
//

import SwiftUI

struct CarInfoDetailsView: View {
    let carInfo: UICarInfo
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("\(carInfo.make) | \(carInfo.series) | \(carInfo.group)")
                .font(.system(size: 22))
                .bold()
            
            Text("Identifier")
                .font(.system(size: UIConstants.PREVIEW_DETAILS_PRIMARY_TEXT_SIZE))
                .foregroundColor(UIConstants.PREVIEW_DETAILS_PRIMARY_TEXT_COLOR)
                .bold()
            Text("\(carInfo.id)")
                .font(.system(size: UIConstants.PREVIEW_DETAILS_SECONDARY_TEXT_SIZE))
                .foregroundColor(UIConstants.PREVIEW_DETAILS_SECONDARY_TEXT_COLOR)
            
            Text("Fuel")
                .font(.system(size: UIConstants.PREVIEW_DETAILS_PRIMARY_TEXT_SIZE))
                .foregroundColor(UIConstants.PREVIEW_DETAILS_PRIMARY_TEXT_COLOR)
                .bold()
            Text("\(carInfo.fuelType) | \(carInfo.fuelLevel) level")
                .font(.system(size: UIConstants.PREVIEW_DETAILS_SECONDARY_TEXT_SIZE))
                .foregroundColor(UIConstants.PREVIEW_DETAILS_SECONDARY_TEXT_COLOR)
            
            Text("Inner Cleanliness")
                .font(.system(size: UIConstants.PREVIEW_DETAILS_PRIMARY_TEXT_SIZE))
                .foregroundColor(UIConstants.PREVIEW_DETAILS_PRIMARY_TEXT_COLOR)
                .bold()
            Text("\(carInfo.innerCleanliness)")
                .font(.system(size: UIConstants.PREVIEW_DETAILS_SECONDARY_TEXT_SIZE))
                .foregroundColor(UIConstants.PREVIEW_DETAILS_SECONDARY_TEXT_COLOR)
            
            Text("License plate")
                .font(.system(size: UIConstants.PREVIEW_DETAILS_PRIMARY_TEXT_SIZE))
                .foregroundColor(UIConstants.PREVIEW_DETAILS_PRIMARY_TEXT_COLOR)
                .bold()
            Text("\(carInfo.licensePlate)")
                .font(.system(size: UIConstants.PREVIEW_DETAILS_SECONDARY_TEXT_SIZE))
                .foregroundColor(UIConstants.PREVIEW_DETAILS_SECONDARY_TEXT_COLOR)
            
            if let color = carInfo.color {
                Text("Color")
                    .font(.system(size: UIConstants.PREVIEW_DETAILS_PRIMARY_TEXT_SIZE))
                    .foregroundColor(UIConstants.PREVIEW_DETAILS_PRIMARY_TEXT_COLOR)
                    .bold()
                
                Rectangle().frame(width: 96, height: 22).foregroundColor(Color(color))
                    .border(Color.white)
            }
        }.frame(maxWidth: .infinity).padding()
    }
}

struct CarInfoDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let carInfo = RentMePreviewData().dummyUICarsInfo.first!
        CarInfoDetailsView(carInfo: carInfo)
    }
}
