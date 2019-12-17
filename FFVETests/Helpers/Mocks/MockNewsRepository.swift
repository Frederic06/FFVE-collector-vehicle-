//
//  MockNewsRepository.swift
//  FFVETests
//
//  Created by Frédéric Blanc on 16/12/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

@testable import FFVE
import Foundation

final class MockNewsRepository: NewsRepositoryType{

    let videos: [VideoItem]?
    
    let error: MyError = .basicError
    
    init(videos: [VideoItem]?) {
        self.videos = videos
    }
    
    func getEvents(completion: @escaping (Result<[VideoItem]>) -> Void) {
        
        if videos != nil {
            completion(.success(value: videos!))
        } else {
            completion(.error(description: error))
        }
    }
}
