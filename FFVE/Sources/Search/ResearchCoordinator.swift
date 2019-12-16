//
//  SearchCoordinator.swift
//  FFVE
//
//  Created by Margarita Blanc on 30/10/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import UIKit

protocol CoordinatorsDelegate: class {
    func createFFVEInfo(function: FunctionCase)
    func dismissed()
}

final class ResearchCoordinator{
    
    // MARK: - Properties
    
    private let presenter: UINavigationController
    private let screens: Screens
    private let delegate: CoordinatorsDelegate
    
    // MARK: - Initializer
    
    init(presenter: UINavigationController, screens: Screens, delegate: CoordinatorsDelegate) {
        self.presenter = presenter
        self.screens = screens
        self.delegate = delegate
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
    
    private func showMembers(filters: FiltersItem) {
        let viewController = screens.createMemberSearchViewController(delegate: self, filters: filters)
        presenter.pushViewController(viewController, animated: true)
    }
    
    private func showAlert(type: AlertType) {
        guard let alert = screens.createAlert(for: type, completion: {
            self.backToStart()
        }) else {return}
        
        presenter.visibleViewController?.present(alert, animated: true)
    }
    
    private func showFFVEInfo() {
        delegate.createFFVEInfo(function: .search)
    }
    
    private func backToStart() {
        print("backToStart")
        start()
    }
}

// MARK: - Extensions

extension ResearchCoordinator: SearchDelegate{
    func alertNoMember() {
        showAlert(type: .noMember)
    }
    
    
    func seeMembers(filters: FiltersItem) {
        showMembers(filters: filters)
    }
    
    func memberChoiceAlert(closure: @escaping(MemberType?) -> Void) {
        
        let alert = screens.createMemberTypeAlert { (type) in
            closure(type)
        }
        
        presenter.visibleViewController?.present(alert, animated: true, completion: nil)
    }
    
    func clubChoiceAlert(closure: @escaping(MemberType?) -> Void) {
        
        let alert = screens.createClubsAlert{ (type) in
            closure(type)
        }
        
        presenter.visibleViewController?.present(alert, animated: true, completion: nil)
    }
    
    func alert(for filter: Filter, dataSource: DepartmentPickerDataSource, didPressOk: @escaping (Bool?) -> Void) {
        let alert = screens.createDepartmentAlertPicker(for: filter, datasource: dataSource, didPressOk: { (response) in
            didPressOk(response)
        })
        presenter.visibleViewController?.present(alert, animated: true, completion: nil)
    }
    
    func didTapOnSearchBar() {
        let viewController = screens.createSearchBarVC(delegate: self)
        presenter.viewControllers = [viewController]
    }
    
    func seeMemberDetail(member: MemberItem) {
        let viewController = screens.createMemberDetailViewController(delegate: self, member: member)
        presenter.pushViewController(viewController, animated: true)
    }
    
    func alert(type: AlertType) {
        showAlert(type: type)
    }
    
    func dismissVC() {
        delegate.dismissed()
//        presenter.popToRootViewController(animated: true)
//        presenter.popViewController(animated: true)
        presenter.visibleViewController?.dismiss(animated: true, completion: nil)
//        presenter.presentingViewController?.dismiss(animated: true, completion: nil)
        showSearch()
    }
    
    func didPressFFVELogo() {
        delegate.createFFVEInfo(function: .search)
    }
}
