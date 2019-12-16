//
//  GLGeocoderHelper.swift
//  FFVE
//
//  Created by Margarita Blanc on 06/12/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import Foundation
import MapKit

final class GLGeocoderHelper {
    
    private var coordinates = Coordinates()
    
    func addCoordinates(members: [MemberItem], completion: ([MemberItem])  -> Void) {
        
        var array: [MemberItem] = []
        
        for var member in members {
            if let coordinates = coordinates.coordinates[member.name] {
                member.latitude = String(coordinates.latitude)
                member.longitude = String(coordinates.longitude)
                member.name = member.name.firstCharacterUpperCase()
                member.city = member.city.firstCharacterUpperCase()
                array.append(member)
            }
            else {
                getCoordinates(adress: "\(member.address1) \(member.city)") { (coordinates) in
                    member.latitude = String(coordinates.latitude)
                    member.longitude = String(coordinates.longitude)
                    member.name = member.name.firstCharacterUpperCase()
                    array.append(member)
                }
            }
        }
        completion(array)
    }
    
    func getCoordinates(adress: String, completion: @escaping (CLLocationCoordinate2D) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(adress) { (placemarks, error) in
            if error == nil {
                if let placemark = placemarks?.first {
                    guard let location = placemark.location?.coordinate else {return}
                    completion(location)
                }
            }
        }
    }
}
