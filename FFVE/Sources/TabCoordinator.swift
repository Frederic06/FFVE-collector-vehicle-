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
    
    private var totemCoordinator: TotemCoordinator?
    
    private var eventCoordinator: EventCoordinator?
    
    private var photoCoordinator: PhotoCoordinator?
    
    private var items = [
        UINavigationController(nibName: nil, bundle: nil),
        UINavigationController(nibName: nil, bundle: nil),
        UINavigationController(nibName: nil, bundle: nil),
        UINavigationController(nibName: nil, bundle: nil)
    ]
    
    private var index = 3
    
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
        tabBarController.selectedViewController = items[3]
        showDiaporama()
    }
    
    // MARK: - Private
    
    private func showResearch() {
        index = tabBarController.selectedIndex
        researchCoordinator = ResearchCoordinator(presenter: items[0] , screens: screens)
        researchCoordinator?.start()
    }
    
    private func showTotems() {
        index = tabBarController.selectedIndex
        totemCoordinator = TotemCoordinator(presenter: items[1] , screens: screens)
        totemCoordinator?.start()
    }
    
    private func showEvents() {
        index = tabBarController.selectedIndex
        eventCoordinator = EventCoordinator(presenter: items[2] , screens: screens)
        eventCoordinator?.start()
    }
    
    private func showDiaporama() {
        photoCoordinator = PhotoCoordinator(presenter: items[3] , screens: screens)
        photoCoordinator?.diaporamaScreen()
    }
    
    private func showPhotos() {
//        tabBarController.selectedIndex = self.index
//        guard let alert = photoChoiceAlert() else {return}
//        items[index].visibleViewController?.present(alert, animated: true, completion: nil)
        photoCoordinator?.start()
    }
    
    private func showGallery() {
        photoCoordinator?.enterGallery()
    }
    
    private func showSubmit() {
        photoCoordinator?.submitPhoto()
    }

    private func configureTabBar() {
        tabBarController.tabBar.barTintColor = #colorLiteral(red: 0.1147654131, green: 0.6290749311, blue: 0.9507474303, alpha: 1)
        tabBarController.tabBar.tintColor = #colorLiteral(red: 0.9999071956, green: 1, blue: 0.999881804, alpha: 1)
        UITabBarItem.appearance().setTitleTextAttributes([ NSAttributedString.Key.font: UIFont(name: "Chalkduster", size: 15.0)! ], for: .normal)
        
        items[0].tabBarItem = UITabBarItem(title: "Recherche", image: nil, tag: 0)
        items[0].tabBarItem.image = UIImage(systemName: "doc.text.magnifyingglass")
        
        items[1].tabBarItem = UITabBarItem(title: "Totems", image: nil, tag: 1)
        items[1].tabBarItem.image = UIImage(systemName: "book")
        
        items[2].tabBarItem = UITabBarItem(title: "Events", image: nil, tag: 1)
        items[2].tabBarItem.image = UIImage(systemName: "calendar.circle")
        
        items[3].tabBarItem = UITabBarItem(title: "Photos", image: nil, tag: 1)
        items[3].tabBarItem.image = UIImage(systemName: "photo")
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
            showTotems()
        case 2:
            showEvents()
        case 3:
            showPhotos()
        default:
            print("error")
        }
    }
}

//extension TabCoordinator {
//
//    private func photoChoiceAlert() -> UIAlertController? {
//
//        let alert = UIAlertController(title: "Que souhaitez vous faire?", message: "", preferredStyle: .alert)
//
//        // Create OK button with action handler
//        let ok = UIAlertAction(title: "Voir la gallerie de la FFVE", style: .default, handler: { (action) -> Void in
//            print("Gallery tapped")
//            self.tabBarController.selectedIndex = 3
//            self.showGallery()
//        })
//
//        // Create Cancel button with action handlder
//        let cancel = UIAlertAction(title: "Soumettre une photo", style: .default) { (action) -> Void in
//            print("Submit tapped")
//            self.tabBarController.selectedIndex = 3
//            self.showSubmit()
//        }
//
//        //Add OK and Cancel button to dialog message
//        alert.addAction(ok)
//        alert.addAction(cancel)
//
//        return alert
//    }
//}
