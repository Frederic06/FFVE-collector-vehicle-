//
//  EventDetailViewController.swift
//  FFVE
//
//  Created by Margarita Blanc on 12/12/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import UIKit
import EventKit

class EventDetailViewController: UIViewController {
    
    var viewModel: EventDetailViewModel!
    
    private let eventStore = EKEventStore()
    
    private var descriptionTableDataSource: DescriptionTableDataSource!
    
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var descriptionTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionTableDataSource = DescriptionTableDataSource(table: descriptionTable)
        
        bind(to: viewModel)
        bind(to: descriptionTableDataSource)
        viewModel.viewDidAppear()
        
        setNavBAr()
    }
    
    // MARK: - Private methods
    
    private func bind(to viewModel: EventDetailViewModel) {
        viewModel.eventItem = { [weak self] event in
            self?.descriptionTableDataSource.update(event: event)
            if let url = URL(string: event.image) {
                if let data = try? Data(contentsOf: url) {
                    self?.image.image = UIImage(data: data)
                }
            }
        }
    }
    
    private func bind(to dataSource: DescriptionTableDataSource){
        dataSource.saveCalendar = viewModel.saveInCalendar
    }
    
    private func setNavBAr() {
        self.navigationItem.title = "Événement"
        let button = UIBarButtonItem(image: UIImage(systemName: "info.circle"), landscapeImagePhone: UIImage(systemName: "info"), style: .done, target: self, action: #selector(buttonInfoTapped))
        self.navigationItem.setRightBarButton(button, animated: true)
    }
    
    private func checkAuthorization() {
        switch EKEventStore.authorizationStatus(for: .event) {
        case .authorized:
            insertEvent(store: eventStore)
        case .denied:
            print("Access denied")
        case .notDetermined:
            // 3
            eventStore.requestAccess(to: .event, completion:
                {[weak self] (granted: Bool, error: Error?) -> Void in
                    if granted {
                        self?.insertEvent(store: self!.eventStore)
                    } else {
                        print("Access denied")
                    }
            })
        default:
            print("Case default")
        }
    }
    
    private func insertEvent(store: EKEventStore) {
        // 1
        let calendars = store.calendars(for: .event)
        
        for calendar in calendars {
            // 2
            if calendar.title == "ioscreator" {
                // 3
                let startDate = Date()
                // 2 hours
                let endDate = startDate.addingTimeInterval(2 * 60 * 60)
                
                // 4
                let event = EKEvent(eventStore: store)
                event.calendar = calendar
                
                event.title = "New Meeting"
                event.startDate = startDate
                event.endDate = endDate
                
                // 5
                do {
                    try store.save(event, span: .thisEvent)
                }
                catch {
                    print("Error saving event in calendar")             }
            }
        }
    }
    
    @objc private func buttonInfoTapped() {
        viewModel.didPressInfo()
    }
}
