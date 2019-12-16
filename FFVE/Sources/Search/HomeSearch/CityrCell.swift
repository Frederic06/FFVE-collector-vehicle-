//
//  CityMemberCell.swift
//  FFVE
//
//  Created by Margarita Blanc on 01/12/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import UIKit

final class CityCell: UITableViewCell {
    
    private var city: String?
    
    func updateCell(with city: String) {
        self.city = city
    }
}
