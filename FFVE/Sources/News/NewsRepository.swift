//
//  TotemRepository.swift
//  FFVE
//
//  Created by Margarita Blanc on 25/11/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import Foundation

protocol NewsRepositoryType {
    func getEvents(completion: @escaping (Result<[VideoItem]>) -> Void)
}

final class NewsRepository: NewsRepositoryType {
    
    private let network: NetworkRequestType
    
    private let route = Route()
    
    // MARK - Init
    
    init(network: NetworkRequestType) {
        self.network = network
    }
    
    // MARK - Public methods
    
    func getEvents(completion: @escaping (Result<[VideoItem]>) -> Void) {
        guard let url = route.getURL(request: .youtube) else {return}
        
        network.request(type: News.self, url: url) { (result) in
            
            switch result {
            case .success(value: let youtubeResponse):
                let news: [VideoItem] = youtubeResponse.items.map{ return VideoItem(mediumSnippet: $0.snippet.thumbnails.medium.url, highSnipper: $0.snippet.thumbnails.high.url, publishedAt: $0.snippet.publishedAt, title: $0.snippet.title, description: $0.snippet.description, videoId: $0.id.videoId, kind: $0.id.kind)
                }
                
                completion(.success(value: news))
                
            case .error(description: _):
                break
            }
        }
    }
}
