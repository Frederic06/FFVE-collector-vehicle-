//
//  DescriptionTableDataSource.swift
//  FFVE
//
//  Created by Margarita Blanc on 12/12/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import UIKit

final class DescriptionTableDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    private var descriptionTable: UITableView
    
    private var event: EventItem?
    
    init(table: UITableView) {
        self.descriptionTable = table
        super.init()
        
        descriptionTable.dataSource = self
        descriptionTable.delegate = self
    }
    
    var saveCalendar: (() -> Void)?
    
    func update(event: EventItem) {
        self.event = event
        descriptionTable.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let event = event else {return nil}
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 100))
        view.backgroundColor = .white
        let label = UILabel(frame: view.bounds)
        label.textColor = #colorLiteral(red: 0.377325654, green: 0.336207211, blue: 0.7377319932, alpha: 1)
        label.font = UIFont(name: "AvenirNext-Bold", size: 30)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = event.title
        label.backgroundColor = .white
        view.addSubview(label)
        return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
            
        case 0:
            let dateCell = tableView.dequeueReusableCell(withIdentifier: "Date", for: indexPath)
            
            if let dateLabel = dateCell.viewWithTag(2) as? UILabel {
                dateLabel.text = event?.transformDateToNiceString()
            }
            
            if let locationLabel = dateCell.viewWithTag(3) as? UILabel {
                locationLabel.text = event?.locationName
                
            }
            return dateCell
            
        case 1:
            let buttonCell = tableView.dequeueReusableCell(withIdentifier: "buttonsCell", for: indexPath)
            
            if let saveButton = buttonCell.viewWithTag(11) as? UIButton {
                saveButton.setTitle("Ajouter au calendrier ⭐️", for: .normal)
                saveButton.setRounded(color: #colorLiteral(red: 0.4138181806, green: 0.3665736616, blue: 0.8065926433, alpha: 1))
                saveButton.addTarget(self, action: #selector(pressedSaveButton(sender:)), for: .touchUpInside)
            }
            return buttonCell
            
        case 2:
                let shortDescriptionCell = tableView.dequeueReusableCell(withIdentifier: "ShortDescription", for: indexPath)
                if let shortDescriptionLabel = shortDescriptionCell.viewWithTag(4) as? UILabel {
                    shortDescriptionLabel.text = event?.description
                }
                return shortDescriptionCell
            
        case 3:
            let longDescriptionCell = tableView.dequeueReusableCell(withIdentifier: "LongDescription", for: indexPath)
            if let longDescriptionLabel = longDescriptionCell.viewWithTag(5) as? UILabel {
                longDescriptionLabel.text = event?.longDescription
            }
            return longDescriptionCell
            
        default:
            break
        }
        return UITableViewCell()
    }
    
    @objc private func pressedSaveButton(sender: UIButton) {
        saveCalendar?()
    }
}
