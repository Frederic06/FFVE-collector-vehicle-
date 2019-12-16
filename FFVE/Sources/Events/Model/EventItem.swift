//
//  EventItem.swift
//  FFVE
//
//  Created by Margarita Blanc on 25/11/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import Foundation

struct EventItem: Equatable {
    let title: String
    let description: String
    let longDescription: String
    let image: String
    let locationName: String
    let firstDate: Date
    let lastDate: Date
    let thumbnail: String
    let eventUrl: String
    let longitude: Double
    let latitude: Double
    
    static func ==(lhs: EventItem, rhs: EventItem) -> Bool {
        return lhs.title == rhs.title && lhs.description == rhs.description && lhs.longDescription == rhs.longDescription && lhs.image == rhs.image && lhs.locationName == rhs.locationName && lhs.firstDate == rhs.firstDate && lhs.lastDate == rhs.lastDate && lhs.thumbnail == rhs.thumbnail && lhs.eventUrl == rhs.eventUrl && lhs.longitude == rhs.longitude && lhs.latitude == rhs.latitude
    }
}
