//
//  EventCoordinator.swift
//  FFVE
//
//  Created by Margarita Blanc on 30/10/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import UIKit

final class EventCoordinator {
    
    // MARK: - Properties
    
    private weak var delegate: CoordinatorsDelegate?
    private let presenter: UINavigationController
    private let screens: Screens
    
    // MARK: - Initializer
    
    init(presenter: UINavigationController, screens: Screens, delegate: CoordinatorsDelegate) {
        self.presenter = presenter
        self.screens = screens
        self.delegate = delegate
    }
    
    // MARK: - Public methods
    
    func start() {
        showEvents()
    }
    
    // MARK: - Private methods
    
    private func showEvents() {
        let viewController = screens.createEventViewController(delegate: self)
        presenter.viewControllers = [viewController]
    }
    
    private func showDetail(event: EventItem) {
        let viewController = screens.createEventDetailViewController(delegate: self, event: event)
        presenter.pushViewController(viewController, animated: true)
    }
    
    private func showAlert(type: AlertType) {
        guard let alert = screens.createAlert(for: type, completion: {}) else {return}
        
        presenter.visibleViewController?.present(alert, animated: true, completion: nil)
    }
}

extension EventCoordinator: EventDelegate {
    func didPressInfo() {
        delegate?.createFFVEInfo(function: .events)
    }
    
    func seeDetail(event: EventItem) {
        showDetail(event: event)
    }
    
    func alert(type: AlertType) {
        showAlert(type: type)
    }
}
