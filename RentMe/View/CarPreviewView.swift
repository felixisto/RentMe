//
//  CarPreviewView.swift
//  RentMe
//
//  Created by Kristiyan Butev on 12.06.21.
//

import SwiftUI

struct CarPreviewView: View {
    @Binding var selectedInfo: UICarInfo?
    
    @StateObject var viewModel: CarPreviewViewModel
    
    @State private var isPresentingError = false
    @State private var errorAlertText = ""
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 0) {
                ZStack(alignment: .top) {
                    Image(uiImage: viewModel.carInfo.carImage ?? UIImage())
                        .resizable()
                        .scaledToFit()
                        .frame(width: nil, height: 196)
                    
                    HStack(alignment: .top, spacing: 0) {
                        Image(uiImage: UIImage(named: "closeButton") ?? UIImage())
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 32, height: 32)
                            .accessibility(identifier: "ClosePreviewButton")
                            .onTapGesture {
                                selectedInfo = nil
                        }
                        
                        Spacer()
                        
                        Text(viewModel.carInfo.name)
                            .font(.system(size: UIConstants.PREVIEW_HEADER_TEXT_SIZE)).bold()
                            .foregroundColor(UIConstants.PREVIEW_HEADER_TEXT_COLOR)
                            .background(UIConstants.PREVIEW_HEADER_TEXT_BACKGROUND_COLOR)
                            .accessibility(identifier: "CarHeaderName")
                    }.padding()
                }.frame(maxWidth: .infinity).background(Color.black)
                
                CarInfoDetailsView(carInfo: viewModel.carInfo)
                
                Spacer()
                
                RentButton()
                    .onTapGesture {
                        errorAlertText = "Demo app."
                        isPresentingError.toggle()
                    }
            }
        }
        .background(UIConstants.PREVIEW_DETAILS_BACKGROUND_COLOR)
        .alert(isPresented: $isPresentingError) {
            Alert(title: Text(errorAlertText))
        }
    }
}

struct CarPreviewView_Previews: PreviewProvider {
    @State var isPresented: Bool = false
    
    static var previews: some View {
        CarPreviewView(selectedInfo: .constant(UICarInfo()), viewModel: viewModel)
    }
    
    static var viewModel: CarPreviewViewModel {
        let carInfo = RentMePreviewData().dummyUICarsInfo.first!
        let vm = CarPreviewViewModel(carInfo: carInfo)
        return vm
    }
}
