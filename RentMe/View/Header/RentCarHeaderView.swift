//
//  RentCarHeaderView.swift
//  RentMe
//
//  Created by Kristiyan Butev on 12.06.21.
//

import SwiftUI

struct RentCarHeaderView: View {
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle().foregroundColor(Color(UIConstants.RENT_HEADER_BACKGROUND_COLOR))
            
            Text("Rent")
                .font(.system(size: UIConstants.RENT_HEADER_TEXT_SIZE))
                .bold()
                .foregroundColor(UIConstants.RENT_HEADER_TEXT_COLOR)
                .padding()
        }
        .frame(width: nil, height: 64)
    }
}

struct RentCarHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        RentCarHeaderView()
    }
}
