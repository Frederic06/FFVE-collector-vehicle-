//
//  ResearchViewModel.swift
//  FFVE
//
//  Created by Margarita Blanc on 31/10/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import Foundation

protocol WelcomeSearchViewModelDelegate: class {
    func seeMembers(type: MemberType)
}

final class WelcomeSearchViewModel {
    
    // MARK: - Properties
    
    private weak var delegate: WelcomeSearchViewModelDelegate?
    
    private var repository: SearchRepository
    
    // MARK: - Init
    
    init(delegate: WelcomeSearchViewModelDelegate, repository: SearchRepository) {
        self.delegate = delegate
        self.repository = repository
    }
    
    // MARK: - Outputs
    
    var presentationText: ((String) -> Void)?
    
    var professionalsText: ((String) -> Void)?

    var clubsButtonText: ((String) -> Void)?
    
    var museumsPhotoText: ((String) -> Void)?
    
    // MARK: - Public methods(Inputs)
    
    func viewDidAppear() {
        presentationText?("Bienvenue sur le portail de recherche de membres de la FFVE. Nous vous souhaitons une agréable recherche")
        clubsButtonText?("Clubs Auto 🚘")
        museumsPhotoText?("Musées 📱")
        professionalsText?("Professionnels 📌")
    }
    
    func didPressClubs() {
        delegate?.seeMembers(type: .Club)
    }
    
    func didPressMuseums() {
        delegate?.seeMembers(type: .Museum)
    }
    
    func didPressProfessionals() {
        delegate?.seeMembers(type: .Professional)
    }
    
    // MARK: - Private methods
    
}
