//
//  TotemCoordinator.swift
//  FFVE
//
//  Created by Margarita Blanc on 30/10/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import UIKit

final class TotemCoordinator {
    
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
        showTotem()
    }
    
    func showTotem() {
        let viewController = screens.createTotemViewController()
        presenter.viewControllers = [viewController]
    }
    
    func showDetail() {
    }
    
    // MARK: - Private methods
    
    private func showAlert() {
    }
}
