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

// MARK: - Research

extension Screens {
    func createResearchViewController(delegate: SearchDelegate) -> UIViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier: "ResearchViewController") as! HomeSearchViewController
        let viewModel = HomeSearchViewModel(delegate: delegate)
        viewController.viewModel = viewModel
        return viewController
    }
}

extension Screens {
    func createSearchBarVC(delegate: SearchDelegate) -> UIViewController{
        let viewController = storyboard.instantiateViewController(identifier: "SearchBarVC") as! SearchBarViewController
        let network = NetworkRequest()
        let repository = SearchRepository(network: network)
        let viewModel = SearchBarViewModel(delegate: delegate, repository: repository)
        viewController.viewModel = viewModel
        return viewController
    }
}

extension Screens {
    func createMemberSearchViewController(delegate: SearchDelegate, filters: FiltersItem) -> UIViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier: "MemberSearchViewController") as! SearchResultsViewController
        let network = NetworkRequest()
        let repository = SearchRepository(network: network)
        let viewModel = SearchResultsViewModel(delegate: delegate, repository: repository, filters: filters)
        viewController.viewModel = viewModel
        return viewController
    }
}

extension Screens {
    func createMemberDetailViewController(delegate: SearchDelegate, member: MemberItem) -> UIViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier: "MemberDetailViewController") as! MemberDetailViewController
        let viewModel = MemberDetailViewModel(delegate: delegate, member: member)
        viewController.viewModel = viewModel
        return viewController
    }
}

// MARK: - Events

extension Screens {
    func createEventViewController(delegate: EventDelegate) -> UIViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier: "EventsViewController") as! EventsViewController
        let network = NetworkRequest()
        let repository = EventsRepository(network: network)
        let viewModel = EventsViewModel(repository: repository, delegate: delegate)
        viewController.viewModel = viewModel
        return viewController
    }
    
    func createEventDetailViewController(delegate: EventDelegate, event: EventItem) -> UIViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier: "EventDetail") as! EventDetailViewController
        
        let viewModel = EventDetailViewModel(delegate: delegate, event: event)
        viewController.viewModel = viewModel
        return viewController
    }
}

// MARK: - News

extension Screens {
    func createNewsViewController(delegate: NewsDelegate) -> UIViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier: "NewsViewController") as! NewsViewController
        let network = NetworkRequest()
        let repository = NewsRepository(network: network)
        let viewModel = NewsViewModel(delegate: delegate, repository: repository)
        viewController.viewModel = viewModel
        return viewController
    }
}
// MARK: -FFVE

extension Screens {
    func createFFVEInfoViewController(functionCase: FunctionCase, delegate: CoordinatorsDelegate) -> UIViewController {
        let viewModel = FFVEInfoViewModel(function: functionCase, delegate: delegate)
        let viewController = storyboard.instantiateViewController(identifier: "FFVEInfoViewController") as! FFVEInfoViewController
        viewController.viewModel = viewModel
        return viewController
    }
}

// MARK : -ALERTS

extension Screens {
    func createAlert(for type: AlertType, completion: @escaping () -> Void) -> UIAlertController? {
        let alert = Alert(type: type)
        let alertController = UIAlertController(title: alert.title, message: alert.message, preferredStyle: .alert)
        let yesButton = UIAlertAction(title: "Ok", style: .cancel) { (_) in
            completion()
        }
        alertController.addAction(yesButton)
        return alertController
    }
    
    func createClubsAlert(completion: @escaping(MemberType?) -> Void) -> UIAlertController{
        
        var member: MemberType? { didSet {
            completion(member)
            }
        }
        
        let alert = Alert(type: .club)
        
        let alertController = UIAlertController(title: alert.title, message: alert.message, preferredStyle: .alert)
        let allAction = UIAlertAction(title: "Tous", style: .default) { (_) in
            member = .club
        }
        let autoAction = UIAlertAction(title: "Automobile", style: .default) { (_) in
            member = .auto(nil)
        }
        let camionAction = UIAlertAction(title: "Camion", style: .default) { (_) in
            member = .camion
        }
        let motoAction = UIAlertAction(title: "Moto", style: .default) { (_) in
            member = .moto
        }
        let utilitaireAction = UIAlertAction(title: "Utilitaire", style: .default) { (_) in
            member = .utilitaire
        }
        let cancelAction = UIAlertAction(title: "Annuler", style: .cancel) { (_) in
            member = nil
        }
        
        alertController.addAction(allAction)
        alertController.addAction(autoAction)
        alertController.addAction(camionAction)
        alertController.addAction(motoAction)
        alertController.addAction(utilitaireAction)
        alertController.addAction(cancelAction)
        
        return alertController
    }
    
    func createMemberTypeAlert(completion: @escaping(MemberType?) -> Void) -> UIAlertController{
        
        var member: MemberType? { didSet {
            completion(member)
            }
        }
        
        let alert = Alert(type: .memberType)
        
        let alertController = UIAlertController(title: alert.title, message: alert.message, preferredStyle: .alert)
        let allAction = UIAlertAction(title: "Tous", style: .default) { (_) in
            member = .all
        }
        let clubActions = UIAlertAction(title: "Clubs", style: .default) { (_) in
            member = .club
        }
        let proAction = UIAlertAction(title: "Professionnels", style: .default) { (_) in
            member = .professional(nil)
        }
        let museumActions = UIAlertAction(title: "Musées", style: .default) { (_) in
            member = .museum
        }
        let cancelAction = UIAlertAction(title: "Annuler", style: .cancel) { (_) in
            member = nil
        }
        
        alertController.addAction(allAction)
        alertController.addAction(clubActions)
        alertController.addAction(proAction)
        alertController.addAction(museumActions)
        alertController.addAction(cancelAction)
        
        return alertController
    }
    
    func createDepartmentAlertPicker(for filter: Filter, datasource: DepartmentPickerDataSource, didPressOk: @escaping(Bool?) -> Void) -> UIAlertController {
        var alert: UIAlertController
        switch filter {
        case .brand:
            alert = UIAlertController(title: "Choisissez une marque", message: "\n\n\n\n\n\n", preferredStyle: .alert)
        case .department:
            alert = UIAlertController(title: "Choisissez un département", message: "\n\n\n\n\n\n", preferredStyle: .alert)
        default:
            alert = UIAlertController(title: "Choisissez une spécialité", message: "\n\n\n\n\n\n", preferredStyle: .alert)
        }
        
        let pickerFrame = UIPickerView(frame: CGRect(x: 5, y: 20, width: 250, height: 140))
        
        alert.view.addSubview(pickerFrame)
        pickerFrame.dataSource = datasource
        pickerFrame.delegate = datasource
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (UIAlertAction) in
            didPressOk(false)
        }))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
            didPressOk(true)
        }))
        return alert
    }
}
