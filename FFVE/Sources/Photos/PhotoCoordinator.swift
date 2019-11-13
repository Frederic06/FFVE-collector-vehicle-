//
//  PhotoCoordinator.swift
//  FFVE
//
//  Created by Margarita Blanc on 30/10/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import UIKit

final class PhotoCoordinator {
    
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
        showPhotos()
    }
    
    func showPhotos() {
        let viewController = screens.createPhotosViewController(delegate: self)
        presenter.viewControllers = [viewController]
    }
    
    
    func diaporamaScreen() {
        let viewController = screens.createDiaporamaViewController()
        presenter.viewControllers = [viewController]
    }
    
    private func showGallery() {
        let viewController = screens.createGalleryViewControoler()
        presenter.pushViewController(viewController, animated: true)
    }
    
    private func showDiaporama() {
        let viewController = screens.createDiaporamaViewController()
        presenter.pushViewController(viewController, animated: true)
    }
    
    private func showSubmit() {
        let viewController = screens.createSubmitViewController()
        presenter.pushViewController(viewController, animated: true)
    }
    
    // MARK: - Private methods

}

extension PhotoCoordinator: PhotosViewModelDelegate {
    func displayAlert() {
    }
    
    func enterGallery() {
        showGallery()
    }
    
    func submitPhoto() {
        showSubmit()
    }
    
    func watchDiaporama() {
        showDiaporama()
    }
}
