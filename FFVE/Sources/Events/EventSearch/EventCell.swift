//
//  EventCell.swift
//  FFVE
//
//  Created by Margarita Blanc on 10/12/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import UIKit

final class EventCell: UITableViewCell {
    
    @IBOutlet weak var dayLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    func updateCell(with event: EventItem) {
        self.dayLabel.text = event.firstDate.transformToDayString()
        self.titleLabel.text = event.title
        self.locationLabel.text = event.locationName
    }
}
