//
//  ResearchViewController.swift
//  FFVE
//
//  Created by Margarita Blanc on 30/10/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import UIKit

final class WelcomeSearchViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var clubAuto: UIButton!
    
    @IBOutlet weak var museum: UIButton!
    
    @IBOutlet weak var professional: UIButton!
    
    @IBOutlet weak var presentation: UILabel!
    
    // MARK: - Properties
    
    var viewModel: WelcomeSearchViewModel!
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind(to: viewModel)
        viewModel.viewDidAppear()
    }
    
    // MARK: - Private methods
    
    private func bind(to viewModel: WelcomeSearchViewModel) {
        viewModel.clubsButtonText = { [weak self] text in
            self?.clubAuto.setTitle(text, for: .normal)
        }
        
        viewModel.museumsPhotoText = { [weak self] text in
            self?.museum.setTitle(text, for: .normal)
        }
        
        viewModel.professionalsText = { [weak self] text in
            self?.professional.setTitle(text, for: .normal)
        }
        
        viewModel.presentationText = { [weak self] text in
            self?.presentation.text = text
            
        }
    }
    
    // MARK: - Actions
    
    @IBAction func clubAuto(_ sender: UIButton) {
        viewModel.didPressClubs()
    }
    
    @IBAction func museum(_ sender: UIButton) {
        viewModel.didPressMuseums()
    }
    
    @IBAction func professional(_ sender: UIButton) {
        viewModel.didPressProfessionals()
    }
    
}

