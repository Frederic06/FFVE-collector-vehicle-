//
//  EventsRepository.swift
//  FFVE
//
//  Created by Margarita Blanc on 25/11/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import Foundation

protocol EventsRepositoryType {
    func getEvents(completion: @escaping (Result<[EventItem]>) -> Void)
}

final class EventsRepository: EventsRepositoryType {
    
    private let network: NetworkRequestType
    
    private let route = Route()
    
    // MARK - Init
    
    init(network: NetworkRequestType) {
        self.network = network
    }
    
    // MARK - Public methods
    
    func getEvents(completion: @escaping (Result<[EventItem]>) -> Void) {
        guard let url = route.getURL(request: .events) else {return}
        
        network.request(type: Event.self, url: url) { (result) in
            switch result {
            case .success(value: let memberItem):
                guard let events: [EventItem] = memberItem.transformToDated() else {return}
                completion(.success(value: events))
            default:
                completion(.error(description: NetworkError.unknown))
            }
        }
    }
}
