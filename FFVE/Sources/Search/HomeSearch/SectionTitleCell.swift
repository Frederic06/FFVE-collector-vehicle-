//
//  SectionTitleCell.swift
//  FFVE
//
//  Created by Margarita Blanc on 01/12/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import UIKit

final class SectionTitleCell: UITableViewCell {
    
    private var title: String?
    
    func updateCell(with title: String) {
        self.title = title
    }
}
