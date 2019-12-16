//
//  MemberCell.swift
//  FFVE
//
//  Created by Margarita Blanc on 25/11/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import UIKit

final class MemberCell: UITableViewCell {
    
    private var member: MemberItem? = nil {
        didSet {
            guard let title = member?.name else { return }
            memberTitle.text = "     \(title)"
            guard let city = member?.city else { return }
            memberCity.text = "     Ville: \(city)"
            guard let type = member?.college else { return }
            switch type {
            case "Professionnels":
                memberType.text = "     Type de membre: Professionnel"
                
            case "Multimarques", "Marques":
                memberType.text = "     Type de membre: Club"
            case "Musées":
                memberType.text = "     Type de membre: Musée"
            default:
                memberType.text = "     Type de membre: \(type)"
            }
        }
    }
    
    @IBOutlet weak var memberType: UILabel!
    
    @IBOutlet weak var memberTitle: UILabel!
    
    @IBOutlet weak var memberCity: UILabel!
    
    func updateCell(with member: MemberItem) {
        self.member = member
    }
}
