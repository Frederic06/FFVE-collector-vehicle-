//
//  PhotosViewController.swift
//  FFVE
//
//  Created by Margarita Blanc on 30/10/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import UIKit

final class PhotosViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var gallery: UIButton!
    
    @IBOutlet weak var diaporama: UIButton!
    
    @IBOutlet weak var submit: UIButton!
    
    // MARK: - Properties
    
    var viewModel: PhotosViewModel!
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind(to: viewModel)
        viewModel.viewDidAppear()
    }
    
    private func bind(to viewModel: PhotosViewModel) {
        
        viewModel.enterGalleryText = { [weak self] text in
            self?.gallery.setTitle(text, for: .normal)
        }
        
        viewModel.diaporamaButtonText = { [weak self] text in
            self?.diaporama.setTitle(text, for: .normal)
        }
        
        viewModel.submitPhotoText = { [weak self] text in
            self?.submit.setTitle(text, for: .normal)
        }
    }
    
    // MARK: - Actions
    
    @IBAction func gallery(_ sender: UIButton) {
        viewModel.didPressEnterGallery()
    }
    
    @IBAction func diaporama(_ sender: UIButton) {
        viewModel.didPressDiaporama()
    }
    
    @IBAction func submit(_ sender: UIButton) {
        viewModel.didPressSubmitPhoto()
    }
    
}
