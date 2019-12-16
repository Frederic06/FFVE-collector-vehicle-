//
//  News.swift
//  FFVE
//
//  Created by Margarita Blanc on 25/11/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import Foundation

struct News: Decodable{

    let items: [Items]

    struct Items: Decodable{
        let kind: String
        let id: Id
        let snippet: Snippet
    }

    struct Id: Decodable{
        let kind: String
        let videoId: String
    }

    struct Snippet: Decodable{
        let publishedAt: String
        let title: String
        let description: String?
        let thumbnails: Thumbnails
    }

    struct Thumbnails: Decodable{
        let medium: Medium
        let high: High
    }

    struct Medium: Decodable{
        let url: String?
    }

    struct High: Decodable{
        let url: String?
    }
}

