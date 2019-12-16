//
//  EventsViewModel.swift
//  FFVE
//
//  Created by Margarita Blanc on 25/11/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import Foundation

protocol EventDelegate: class {
    func didPressInfo()
    func seeDetail(event: EventItem)
    func alert(type: AlertType)
}

final class EventsViewModel {
    
    private var repository: EventsRepositoryType
    
    private weak var delegate: EventDelegate?
    
    init(repository: EventsRepositoryType, delegate: EventDelegate) {
        self.repository = repository
        self.delegate = delegate
    }
    
    var eventItems: (([EventItem]) -> Void)?
    
    var activityIsHidden: ((Bool) -> Void)?
    
    var tableHidden : ((Bool) -> Void)?
    
    func viewDidAppear() {
        tableHidden?(true)
        activityIsHidden?(false)
        repository.getEvents(completion: { (result) in
            switch result {
            case .success(value: let events):
                self.eventItems?(events)
                self.activityIsHidden?(true)
                self.tableHidden?(false)
                    break
            case .error(description: let erroCase):
                switch erroCase {
                default:
                    break
                }
            }
        })
    }
    
    func didPressInfoLogo() {
        delegate?.didPressInfo()
    }
    
    func didChooseEvent(event: EventItem) {
        delegate?.seeDetail(event: event)
    }
}
