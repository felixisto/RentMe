//
//  BoxMapViewModel.swift
//  RentMe
//
//  Created by Kristiyan Butev on 13.06.21.
//

import Combine
import Resolver
import Mapbox

class BoxMapViewModel: NSObject, ObservableObject {
    @Published var carsInfo: [UICarInfo] {
        didSet {
            initLastSavedPositionIfNeeded()
        }
    }
    
    @Published var selectedCarInfo: UICarInfo?
    @Published var lastErrorMessage: String?
    
    var defaultPosition: CarMapPosition = CarMapConstraints.DEFAULT_POSITION
    
    var lastSavedPosition: CarMapPosition?
    
    var carPositions: [CarMapPosition] {
        Self.parseCarInfoToPositions(infos: carsInfo)
    }
    
    var carAnnotations: [CarMapAnnotation] {
        var pointAnnotations = [CarMapAnnotation]()
        
        for info in carsInfo {
            pointAnnotations.append(CarMapAnnotation(info: info))
        }
        
        return pointAnnotations
    }
    
    @Injected var map: CarMap
    @Injected var annotationImageHandler: CarMapAnnotationImageHandler
    @Injected var errorHandling: ErrorHandling
    @Injected var networkStatus: NetworkStatusChecker
    
    init(carsInfo: [UICarInfo]) {
        self.carsInfo = carsInfo
        
        super.init()
        
        initLastSavedPositionIfNeeded()
        
        updateDefaultPosition()
    }
    
    private func initLastSavedPositionIfNeeded() {
        if lastSavedPosition == nil && !carsInfo.isEmpty {
            lastSavedPosition = CarMapPosition(lat: carsInfo[0].latitude, lon: carsInfo[0].longitude)
            updateDefaultPosition()
        }
    }
    
    private func updateDefaultPosition() {
        self.defaultPosition = lastSavedPosition ?? CarMapConstraints.DEFAULT_POSITION
    }
    
    static func parseCarInfoToPositions(infos: [UICarInfo]) -> [CarMapPosition] {
        return infos.map { (info) -> CarMapPosition in
            return Self.parseCarInfoToPosition(info: info)
        }
    }
    
    static func parseCarInfoToPosition(info: UICarInfo) -> CarMapPosition {
        return CarMapPosition(lat: info.latitude, lon: info.longitude)
    }
}

extension BoxMapViewModel: MGLMapViewDelegate {
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        return true
    }
    
    func mapViewRegionIsChanging(_ mapView: MGLMapView) {
        networkStatus.refresh()
        
        defaultPosition = CarMapPosition(point: mapView.centerCoordinate)
    }
    
    func mapView(_ mapView: MGLMapView, didSelect annotation: MGLAnnotation) {
        networkStatus.refresh()
        
        if let id = (annotation as? CarMapAnnotation)?.id {
            self.selectedCarInfo = carInfo(forID: id)
        }
    }
    
    func mapView(_ mapView: MGLMapView, didDeselect annotation: MGLAnnotation) {
        guard let deselectedAnnotation = annotation as? CarMapAnnotation else {
            return
        }
        
        networkStatus.refresh()
        
        if let selectedAnnotation = self.selectedCarInfo {
            if selectedAnnotation.id == deselectedAnnotation.id {
                self.selectedCarInfo = nil
            }
        }
    }
    
    func mapView(_ mapView: MGLMapView, imageFor annotation: MGLAnnotation) -> MGLAnnotationImage? {
        return annotationImageHandler.handle(mapView: mapView, imageFor: annotation)
    }
    
    func mapViewWillStartLoadingMap(_ mapView: MGLMapView) {
        lastErrorMessage = nil
    }
    
    func mapViewDidFailLoadingMap(_ mapView: MGLMapView, withError error: Error) {
        lastErrorMessage = errorHandling.userFriendlyMessage(forError: error)
    }
    
    func mapView(_ mapView: MGLMapView, didFailToLocateUserWithError error: Error) {
        lastErrorMessage = errorHandling.userFriendlyMessage(forError: error)
    }
    
    private func carInfo(forID id: String) -> UICarInfo? {
        return carsInfo.first { (info) -> Bool in
            info.id == id
        }
    }
}

class CustomImageAnnotationView: MGLAnnotationView {
    var imageView: UIImageView!

    required init(reuseIdentifier: String?, image: UIImage) {
        super.init(reuseIdentifier: reuseIdentifier)

        self.imageView = UIImageView(image: image)
        self.addSubview(self.imageView)
        self.frame = self.imageView.frame
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
}

