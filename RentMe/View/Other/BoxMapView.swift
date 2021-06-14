//
//  BoxMapView.swift
//  RentMe
//
//  Created by Kristiyan Butev on 13.06.21.
//

import SwiftUI
import Mapbox

struct BoxMapView: View {
    @StateObject var viewModel: BoxMapViewModel
    
    var body: some View {
        if let errorMessage = viewModel.lastErrorMessage {
            GenericErrorMessageView(message: errorMessage)
                .background(UIConstants.MAP_BACKGROUND_COLOR)
        } else {
            BoxMapUIView(viewModel: viewModel)
        }
    }
}

struct BoxMapUIView: UIViewRepresentable {
    var viewModel: BoxMapViewModel
    
    private let map = MGLMapView(frame: .zero, styleURL: MGLStyle.outdoorsStyleURL)
    
    func makeUIView(context: UIViewRepresentableContext<BoxMapUIView>) -> MGLMapView {
        let defaultPosition = viewModel.defaultPosition.asCLLocation
        
        map.allowsRotating = false
        map.allowsTilting = false
        
        map.setCenter(defaultPosition, zoomLevel: CarMapConstraints.DEFAULT_ZOOM_LEVEL, animated: false)
        
        map.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        map.showsScale = true
        
        map.delegate = viewModel
        map.addAnnotations(self.viewModel.carAnnotations)
        
        return map
    }

    func updateUIView(_ uiView: MGLMapView, context: UIViewRepresentableContext<BoxMapUIView>) {
        
    }
}
