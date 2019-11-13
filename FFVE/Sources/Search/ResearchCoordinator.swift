//
//  SearchCoordinator.swift
//  FFVE
//
//  Created by Margarita Blanc on 30/10/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import UIKit

final class ResearchCoordinator{
    
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
        showSearch()
    }

    
    func showSearch() {
        let viewController = screens.createResearchViewController(delegate: self)
        presenter.viewControllers = [viewController]
    }
    
    // MARK: - Private methods
    
    private func showMembers(type: MemberType) {
        let viewController = screens.createMemberSearchViewController(delegate: self, memberType: type)
        presenter.pushViewController(viewController, animated: true)
    }
    
    private func showAlert() {
    }
}

extension ResearchCoordinator: WelcomeSearchViewModelDelegate {
    func seeMembers(type: MemberType) {
        showMembers(type: type)
    }
}

extension ResearchCoordinator: MemberSearchViewModelDelegate {
    func seeClubDetail(member: Member) {
    }
}
