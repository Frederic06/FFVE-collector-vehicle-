//
//  Event.swift
//  FFVE
//
//  Created by Margarita Blanc on 25/11/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import Foundation

struct Event: Decodable {
    
    let events: [Events]
    
    struct Events: Decodable{
        let title: Title
        let description: Description
        let longDescription: LongDescription
        let registrationUrl: String
        let image: String
        let thumbnail: String
        let firstDate: String
        let lastDate: String
        let latitude: Double
        let longitude: Double
        let locationName: String
    }
    
    struct Location: Decodable{
        let address: String
        let city: String
    }
    
    struct Title: Decodable{
        let fr: String
    }
    
    struct Description: Decodable{
        let fr: String
    }
    
    struct LongDescription: Decodable {
        let fr: String
    }
}
