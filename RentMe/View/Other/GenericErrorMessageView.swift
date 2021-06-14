//
//  GenericErrorMessageView.swift
//  RentMe
//
//  Created by Kristiyan Butev on 13.06.21.
//

import SwiftUI

struct GenericErrorMessageView: View {
    let message: String
    
    var body: some View {
        GeometryReader { geo in
            Text(message)
                .bold()
                .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
        }
        .frame(width: nil, height: nil, alignment: .center)
    }
}

struct GenericErrorMessageView_Previews: PreviewProvider {
    static var previews: some View {
        GenericErrorMessageView(message: "Unknown error")
    }
}
