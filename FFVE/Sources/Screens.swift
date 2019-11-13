//
//  Screens.swift
//  FFVE
//
//  Created by Margarita Blanc on 30/10/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import UIKit

enum photoChoice {
    case Gallery, Upload
}

final class Screens {
    let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: Screens.self))
}

// MARK: - Home

extension Screens {
    func createDiaporamaViewController() -> UIViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier: "Diaporama") as! DiaporamaViewController
        return viewController
    }
}

// MARK: - Research

extension Screens {
    func createResearchViewController(delegate: WelcomeSearchViewModelDelegate) -> UIViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier: "ResearchViewController") as! WelcomeSearchViewController
        let network = Network()
        let repository = SearchRepository(network: network)
        let viewModel = WelcomeSearchViewModel(delegate: delegate, repository: repository)
        viewController.viewModel = viewModel
        return viewController
    }
}

extension Screens {
    func createMemberSearchViewController(delegate: MemberSearchViewModelDelegate, memberType: MemberType) -> UIViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier: "MemberSearchViewController") as! MemberSearchViewController
        let network = Network()
        let repository = SearchRepository(network: network)
        let viewModel = MemberResearchViewModel(delegate: delegate, repository: repository, memberType: memberType)
        viewController.viewModel = viewModel
        return viewController
    }
}

extension Screens {
    func createMemberDetailViewController() -> UIViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier: "MemberDetailViewController") as! MemberDetailViewController
        return viewController
    }
}

// MARK: - Totem

extension Screens {
    func createTotemViewController() -> UIViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier: "TotemViewController") as! TotemViewController
        return viewController
    }
}

// MARK: - Events

extension Screens {
    func createEventViewController() -> UIViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier: "EventsViewController") as! EventsViewController
        return viewController
    }
}

// MARK: - Photos

extension Screens {
    func createPhotosViewController(delegate: PhotosViewModelDelegate) -> UIViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier: "PhotosViewController") as! PhotosViewController
        let repository = PhotosRepository()
        let viewModel = PhotosViewModel(delegate: delegate, repository: repository)
        viewController.viewModel = viewModel
        return viewController
    }
}

extension Screens {
    func createGalleryViewControoler() -> UIViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier: "GalleryViewController") as! GalleryViewController
        return viewController
    }
}

extension Screens {
    func createSubmitViewController() -> UIViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier: "SubmitViewController") as! SubmitViewController
        return viewController
    }
}



