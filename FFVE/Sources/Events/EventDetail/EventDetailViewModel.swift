//
//  EventDetailViewModel.swift
//  FFVE
//
//  Created by Margarita Blanc on 12/12/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import Foundation

final class EventDetailViewModel {
    
    // MARK: - Properties
    
    private let delegate: EventDelegate!
    
    private let event: EventItem!
    
    // MARK: - Init
    
    init(delegate: EventDelegate, event: EventItem) {
        self.delegate = delegate
        self.event = event
    }
    
    // MARK: - Outputs
    
    var eventItem: ((EventItem) -> Void)?
    
    var mapHidden: ((Bool) -> Void)?
    
    func viewDidAppear() {
        eventItem?(event)
        mapHidden?(true)
    }
    
    func didPressInfo() {
        delegate.didPressInfo()
    }
    
    func saveInCalendar() {
    }
}
