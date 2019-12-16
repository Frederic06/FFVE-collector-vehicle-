//
//  NewsItem.swift
//  FFVE
//
//  Created by Margarita Blanc on 25/11/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import Foundation

struct VideoItem: Equatable {
    let mediumSnippet: String?
    let highSnipper: String?
    let publishedAt: String
    let title: String
    let description: String?
    let videoId: String
    let kind: String
    
    static func ==(lhs: VideoItem, rhs: VideoItem) -> Bool {
        return lhs.mediumSnippet == rhs.mediumSnippet && lhs.highSnipper == rhs.highSnipper && lhs.publishedAt == rhs.publishedAt && lhs.title == rhs.title && lhs.description == rhs.description && lhs.videoId == rhs.videoId && lhs.kind == rhs.kind
    }
}
