//
//  EventsViewController.swift
//  FFVE
//
//  Created by Margarita Blanc on 30/10/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import UIKit

final class EventsViewController: UIViewController {
    
    var viewModel: EventsViewModel!
    
    @IBOutlet weak var eventTable: UITableView!
    
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    private var eventTableDataSource: EventTableDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventTableDataSource = EventTableDataSource(table: eventTable)
        
        bind(to: viewModel)
        bind(to: eventTableDataSource)
        viewModel.viewDidAppear()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUI()
    }
    
    @objc private func buttonInfoTapped() {
        viewModel.didPressInfoLogo()
    }
    
    private func bind(to viewModel: EventsViewModel) {
        viewModel.eventItems = {[weak self] events in
            self?.eventTableDataSource.updateCells(with: events)
        }
        
        viewModel.activityIsHidden = { [weak self] state in
            if state == false {
                self?.activity.startAnimating()
                
            } else {
                self?.activity.stopAnimating()
            }
            self?.activity.isHidden = state
        }
        
        viewModel.tableHidden = { [weak self] state in
            self?.eventTable.isHidden = state
        }
    }
    
    private func bind(to dataSource: EventTableDataSource) {
        dataSource.didChooseEvent = viewModel.didChooseEvent
    }
    
    private func setUI() {
        activity.transform = CGAffineTransform.init(scaleX: 2, y: 2)
        setNavBar()
    }
    
    private func setNavBar() {
        self.navigationItem.title = "Calendrier"
        let button = UIBarButtonItem(image: UIImage(systemName: "info.circle"), landscapeImagePhone: UIImage(systemName: "info"), style: .done, target: self, action: #selector(buttonInfoTapped))
        self.navigationItem.setRightBarButton(button, animated: true)
    }
}
