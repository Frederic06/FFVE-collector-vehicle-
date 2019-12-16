//
//  MemberMap.swift
//  FFVE
//
//  Created by Frédéric Blanc on 04/12/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//


import UIKit
import MapKit

final class MemberMap: NSObject, MKMapViewDelegate {
    
    
    private var map: MKMapView
    
    var member:MemberItem? {
        didSet {
            guard let item = member else {return}
            addAnnotations(member: item)
        }
    }
    
    private var centerLatitude: Double?
    
    private var centerLongitude: Double?
    
    init(map: MKMapView) {
        self.map = map
        super.init()
        map.delegate = self
    }
    
    func update(member: MemberItem) {
        self.member = member
        self.addAnnotations(member: member)
    }
    
    private func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: 10000, longitudinalMeters: 10000)
        map.setRegion(coordinateRegion, animated: true)
    }
    
    private func addAnnotations(member: MemberItem) {
        let annotation = MKPointAnnotation()
        guard let latitudeString = member.latitude else { return }
        guard let longitudeString = member.longitude else { return }
        guard let latitude = Double(latitudeString) else { return }
        guard let longitude = Double(longitudeString) else { return }
        
        annotation.title = member.name
        annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        centerMapOnLocation(location: CLLocation(latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude))
        map.addAnnotation(annotation)
    }
}
