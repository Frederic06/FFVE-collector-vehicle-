//
//  MapDataSource.swift
//  FFVE
//
//  Created by Margarita Blanc on 02/11/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.

import UIKit
import MapKit

final class MapDataSource: NSObject, MKMapViewDelegate {
    
    // MARK: - Properties
    
    private var map: MKMapView
    
    private var zoom: ZoomType!
    
    private var glGeocoderHelper = GLGeocoderHelper()
    
    private var centerPoint: String?

    private enum Item {
        case annotation(location: CLLocation, title: String, subtitle: String)
    }

    private var items: [Item] = [] {
        didSet {
            addAnnotations(memberLocations: items)
        }
    }
    
    // MARK: - Init

    init(map: MKMapView) {
        self.map = map
        super.init()
        map.delegate = self
    }
    
    // MARK: - Outputs
    
    var chosenMember: ((String) -> Void)?
    
    // MARK: - Public methods
    
    func updateZoom(centeredOn: ZoomType) {
        self.zoom = centeredOn
    }
    
    func constructItems(with members: [MemberItem]) {
        self.items = members.compactMap {
            guard
                let latitudeStr = $0.latitude,
                let latitude = Double(latitudeStr),
                let longitudeStr = $0.longitude,
                let longitude = Double(longitudeStr)
                else { return nil }
            
            return Item.annotation(location: CLLocation(latitude: latitude,
                                                        longitude: longitude),
                                                        title: $0.name,
                                                        subtitle: $0.atype)
        }
        if zoom == .city {
            getCityCenter(adress: members[0].city)
        } else if zoom == .department {
            getCenterCoordinates(items: self.items)
        }
    }
    
    // MARK: - Private methods
    
    private func getCenterCoordinates(items: [Item]) {
                var latitudes: [Double] = []
                var longitudes: [Double] = []
        
                for item in items {
                    switch item {
                    case .annotation(location: let location, title: _, subtitle: _):
                        latitudes.append(location.coordinate.latitude)
                        longitudes.append(location.coordinate.longitude)
                    }
                }
        
                guard
                    latitudes.max() != nil &&
                    latitudes.min() != nil &&
                    longitudes.max() != nil &&
                    longitudes.min() != nil
                    else { return }
        
                let longitude = (longitudes.max()!+longitudes.min()!)/2
                let latitude = (latitudes.max()!+latitudes.min()!)/2
                let cllocation = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                centerMapOnLocation(location: cllocation)
    }
    
    private func getCityCenter(adress: String) {
        glGeocoderHelper.getCoordinates(adress: adress) { (coordinates) in
            self.centerMapOnLocation(location: coordinates)
        }
    }
    
    private func centerMapOnLocation(location: CLLocationCoordinate2D) {
        let coordinateRegion = MKCoordinateRegion(center: location,
                                                  latitudinalMeters: zoom.rawValue, longitudinalMeters: zoom.rawValue)
        map.setRegion(coordinateRegion, animated: true)
    }
    
    private func addAnnotations(memberLocations: [Item]) {
        for item in memberLocations {
            switch item {
            case .annotation(location: let location, title: let title, subtitle: let subtitle):
                let annotation = MKPointAnnotation()
                annotation.title = title
                annotation.coordinate = location.coordinate
                annotation.subtitle = subtitle
                map.addAnnotation(annotation)
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
          as? MKMarkerAnnotationView {
          dequeuedView.annotation = annotation
          view = dequeuedView
        } else {
          
          view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
          view.canShowCallout = true
          view.calloutOffset = CGPoint(x: -5, y: 5)
          view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
        calloutAccessoryControlTapped control: UIControl) {
        
        if let name = view.annotation?.title {
            chosenMember?(name!)
        }
    }
}
