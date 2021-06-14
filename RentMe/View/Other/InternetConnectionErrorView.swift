//
//  InternetConnectionErrorView.swift
//  RentMe
//
//  Created by Kristiyan Butev on 14.06.21.
//

import SwiftUI

struct InternetConnectionErrorView: View {
    var body: some View {
        GeometryReader { geo in
            Text("Connection issue")
                .bold()
                .frame(width: geo.size.width, height: 32)
                .foregroundColor(Color.white)
                .background(Color.red)
        }
    }
}

struct InternetConnectionErrorView_Previews: PreviewProvider {
    static var previews: some View {
        InternetConnectionErrorView()
    }
}
