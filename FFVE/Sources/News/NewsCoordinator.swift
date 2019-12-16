//
//  TotemCoordinator.swift
//  FFVE
//
//  Created by Margarita Blanc on 30/10/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import UIKit

final class NewsCoordinator {
    
    // MARK: - Properties
    
    private let presenter: UINavigationController
    private let screens: Screens
    private weak var delegate: CoordinatorsDelegate?
    
    
    // MARK: - Initializer
    
    init(presenter: UINavigationController, screens: Screens, delegate: CoordinatorsDelegate) {
        self.presenter = presenter
        self.screens = screens
        self.delegate = delegate
    }
    
    // MARK: - Public methods
    
    func start() {
        showTotem()
    }
    
    func showTotem() {
        let viewController = screens.createNewsViewController(delegate: self)
        presenter.viewControllers = [viewController]
    }
    
    func showDetail() {
    }
    
    // MARK: - Private methods
    
    private func showAlert() {
    }
}

extension NewsCoordinator: NewsDelegate{
    
    func didPressFFVELogo() {
        delegate?.createFFVEInfo(function: .video)
    }
}
