//
//  TabCoordinator.swift
//  FFVE
//
//  Created by Margarita Blanc on 30/10/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import UIKit

final class TabCoordinator: NSObject {
    
    // MARK: - Properties
    
    private var presenter: UIWindow
    
    private var screens: Screens
    
    private var tabBarController = UITabBarController(nibName: nil, bundle: nil)
    
    private var researchCoordinator: ResearchCoordinator?
    
    private var totemCoordinator: NewsCoordinator?
    
    private var eventCoordinator: EventCoordinator?
    
    private var homeViewController: UIViewController?
    
    private var items = [
        UINavigationController(nibName: nil, bundle: nil),
        UINavigationController(nibName: nil, bundle: nil),
        UINavigationController(nibName: nil, bundle: nil)
    ]
    
    // MARK: - Initializer
    
    init(presenter: UIWindow) {
        self.presenter = presenter
        
        screens = Screens()
        
        super.init()
        
        tabBarController.viewControllers = items
        
        tabBarController.delegate = self
        
        configureTabBar()
    }
    
    // MARK: - Start
    
    func start() {
        presenter.rootViewController = tabBarController
        tabBarController.selectedViewController = items[0]
        showResearch()
    }
    
    // MARK: - Private
    
    private func showResearch() {
        researchCoordinator = ResearchCoordinator(presenter: items[0] , screens: screens, delegate: self)
        researchCoordinator?.start()
    }
    
    private func showEvents() {
        eventCoordinator = EventCoordinator(presenter: items[1] , screens: screens, delegate: self)
        eventCoordinator?.start()
    }
    
    private func showNews() {
        totemCoordinator = NewsCoordinator(presenter: items[2] , screens: screens, delegate: self)
        totemCoordinator?.start()
    }
    
    private func configureTabBar() {
        tabBarController.tabBar.barTintColor = #colorLiteral(red: 0.312418133, green: 0.2647294402, blue: 0.7769268155, alpha: 1)
        tabBarController.tabBar.tintColor = #colorLiteral(red: 0.9999071956, green: 1, blue: 0.999881804, alpha: 1)
        UITabBarItem.appearance().setTitleTextAttributes([ NSAttributedString.Key.font: UIFont(name: "Chalkduster", size: 15.0)! ], for: .normal)
        
        items[0].tabBarItem = UITabBarItem(title: "Recherche", image: nil, tag: 0)
        items[0].tabBarItem.image = UIImage(systemName: "magnifyingglass.circle")
        
        items[1].tabBarItem = UITabBarItem(title: "Calendrier", image: nil, tag: 1)
        items[1].tabBarItem.image = UIImage(systemName: "calendar.circle")
        
        items[2].tabBarItem = UITabBarItem(title: "Vidéo", image: nil, tag: 1)
        items[2].tabBarItem.image = UIImage(systemName: "video.circle")
    }
}

extension TabCoordinator: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        // We get the index, and we check if its exists
        let index = tabBarController.selectedIndex
        
        guard index < self.items.count else {
            fatalError("Index out of range 🔥")
        }
        
        switch index {
        case 0:
            showResearch()
        case 1:
            showEvents()
        case 2:
            showNews()
            
        default:
            print("error")
        }
    }
}

extension TabCoordinator: CoordinatorsDelegate {
    func dismissed() {
        presenter.rootViewController?.dismiss(animated: true, completion: nil)
        start()
        print("start")
    }
    
    func createFFVEInfo(function: FunctionCase) {
        let viewController = screens.createFFVEInfoViewController(functionCase: function, delegate: self)
        presenter.rootViewController?.present(viewController, animated: true)
    }
}
