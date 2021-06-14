//
//  RentButton.swift
//  RentMe
//
//  Created by Kristiyan Butev on 12.06.21.
//

import SwiftUI

struct RentButton: View {
    var body: some View {
        Text("Rent")
            .font(.system(size: 22))
            .bold()
            .foregroundColor(Color.white)
            .padding()
            .background(Color.orange)
    }
}

struct RentButton_Previews: PreviewProvider {
    static var previews: some View {
        RentButton()
    }
}
