//
//  ClubResearchViewModel.swift
//  FFVE
//
//  Created by Margarita Blanc on 02/11/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import Foundation

protocol MemberSearchViewModelDelegate: class {
    func seeClubDetail(member: Member)
}

final class MemberResearchViewModel {
    
    // MARK: - Properties
    
    private weak var delegate: MemberSearchViewModelDelegate?
    
    private var repository: SearchRepository
    
    private var memberType: MemberType
    
    private var members: [Member]?
    
    // MARK: - Init
    
    init(delegate: MemberSearchViewModelDelegate, repository: SearchRepository, memberType: MemberType) {
        self.delegate = delegate
        self.repository = repository
        self.memberType = memberType
        print(memberType)
    }
    
    // MARK: - Outputs
    
    var title: ((String) -> Void)?
    
    var criteriaTitle: ((String) -> Void)?
    
    var departmentTitle: ((String) -> Void)?
    
    var specialityPickerIsOn: ((Bool) -> Void)?
    
    var specialityTitle: ((String)-> Void)?
    
    var switchTitle: ((String) -> Void)?
    
    var departmentPickerTitle: ((String) -> Void)?
    
    var specialityPickerTitle: ((String) -> Void)?
    
    var specialityPickerList: (([String]) -> Void)?
    
    var departmentPickerList: (([String]) -> Void)?
    

    
    // MARK: - Public methods(Inputs)
    
    func viewDidAppear() {
        switchTitle?("Liste / Carte")
        criteriaTitle?("Affiner par:")
        departmentPickerTitle?("Département")

        
        switch memberType {
        case .Club:
            specialityTitle?("Marque")
            specialityPickerIsOn?(true)
            title?("\(members?.count) clubs auto recensés")
        case .Museum:
            specialityTitle?("")
            specialityPickerIsOn?(false)
            title?("\(members?.count) musées auto recensés")
        case .Professional:
            specialityTitle?("Spécialité")
            title?("\(members?.count) professionels auto recensés")
            specialityPickerIsOn?(true)
        }
    }
    
    // MARK: - Private methods
    
}
