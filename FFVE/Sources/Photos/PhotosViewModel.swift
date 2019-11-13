//
//  PhotosViewModel.swift
//  FFVE
//
//  Created by Margarita Blanc on 31/10/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import Foundation

protocol PhotosViewModelDelegate: class {
    func displayAlert()
    func enterGallery()
    func submitPhoto()
    func watchDiaporama()
}

final class PhotosViewModel {
    
    // MARK: - Properties
    
    private weak var delegate: PhotosViewModelDelegate?
    
    private var repository: PhotosRepository
    
    // MARK: - Init
    
    init(delegate: PhotosViewModelDelegate, repository: PhotosRepository) {
        self.delegate = delegate
        self.repository = repository
    }
    
    // MARK: - Outputs
    
    var diaporamaButtonText: ((String) -> Void)?
    
    var submitPhotoText: ((String) -> Void)?
    
    var enterGalleryText: ((String) -> Void)?
    
    // MARK: - Public methods(Inputs)
    
    func viewDidAppear() {
        diaporamaButtonText?("Diaporama 🚘")
        submitPhotoText?("Soumettre une photo 📱")
        enterGalleryText?("Voir la gallerie 📌")
    }
    
    func didPressDiaporama() {
        delegate?.watchDiaporama()
    }
    
    func didPressSubmitPhoto() {
        delegate?.submitPhoto()
    }
    
    func didPressEnterGallery() {
        delegate?.enterGallery()
    }
    
    // MARK: - Private methods
    
}
