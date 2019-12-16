//
//  MemberDetailViewModel.swift
//  FFVE
//
//  Created by Margarita Blanc on 25/11/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import Foundation

final class MemberDetailViewModel {
    
    // MARK: - Properties
    
    private var member: MemberItem
    
    private weak var delegate: SearchDelegate?
    
    // MARK: - Init
    
    init(delegate: SearchDelegate, member: MemberItem) {
        self.delegate = delegate
        self.member = member
    }
    
    // MARK: - Outputs
    
    var memberNameLabelText: ((String) -> Void)?
    var memberTypeLabelText: ((String) -> Void)?
    var presidentLabelText: ((String) -> Void)?
    var coordinatesLabelText: ((String) -> Void)?
    var adressLabelText: ((String) -> Void)?
    
    var memberItem: ((MemberItem) -> Void)?
    
    // MARK: - Public methods(Inputs)
    
    func viewDidAppear() {
        memberNameLabelText?(member.name)
        memberTypeLabelText?(member.college.getMemberTypeLabelText())
        presidentLabelText?("Président: \(member.pres_nom) \(member.pres_prenom)")
        coordinatesLabelText?("""
            📞 \(member.tel1)
            ✉️ \(member.email)
            """)
        adressLabelText?("""
\(member.address1)
\(member.postal_code) \(member.city)
""")
        memberItem?(member)
    }
    
    func didPressInfoLogo() {
        delegate?.didPressFFVELogo()
    }
}
