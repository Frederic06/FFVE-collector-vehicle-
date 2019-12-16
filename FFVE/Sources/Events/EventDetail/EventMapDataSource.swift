//
//  EventMapDataSource.swift
//  FFVE
//
//  Created by Margarita Blanc on 14/12/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import Foundation

import UIKit
import MapKit

final class EventMapDataSource: NSObject, MKMapViewDelegate {
    
    // MARK: - Properties
    
    private var map: MKMapView
    
    private var event: EventItem? {
        didSet {
            guard let event = event else { return }
            addAnnotations(event: event)
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
    
    func update(with event: EventItem) {
        self.event = event
    }
    
    private func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: 1000, longitudinalMeters: 1000)
        map.setRegion(coordinateRegion, animated: true)
    }
    
    private func addAnnotations(event: EventItem) {
        
        let annotation = MKPointAnnotation()
        
        let latitude = Double(event.latitude)
        let longitude = Double(event.longitude)
        
        annotation.title = event.locationName
        annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        centerMapOnLocation(location: CLLocation(latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude))
        map.addAnnotation(annotation)
    }
}
