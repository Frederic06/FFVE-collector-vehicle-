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
    
    private let presenter: UINavigationController
    private let screens: Screens
    
    // MARK: - Initializer
    
    init(presenter: UINavigationController, screens: Screens) {
        self.presenter = presenter
        self.screens = screens
    }
    
    // MARK: - Public methods
    
    func start() {
        showEvents()
    }
    
    func showEvents() {
        let viewController = screens.createEventViewController()
        presenter.viewControllers = [viewController]
    }
    
    func showDetail() {
    }
    
    // MARK: - Private methods
    
    private func showAlert() {
    }
}
