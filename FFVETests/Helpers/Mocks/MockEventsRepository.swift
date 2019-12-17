//
//  MockEventsRepository.swift
//  FFVETests
//
//  Created by Frédéric Blanc on 16/12/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

@testable import FFVE
import Foundation

enum MyError: Error {
    case runtimeError(String)
    case basicError
}

final class MockEventsRepository: EventsRepositoryType{
    
    let events: [EventItem]?
    var thrownError: MyError = .basicError
    
    init(events: [EventItem]?) {
        self.events = events
    }
    
    func getEvents(completion: @escaping (Result<[EventItem]>) -> Void) {
        if events != nil {
            completion(.success(value: events!))
        } else {
            completion(.error(description: thrownError))
        }
    }
    
    
}
