//
//  TotemViewModel.swift
//  FFVE
//
//  Created by Margarita Blanc on 25/11/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import Foundation

protocol NewsDelegate: class{
    func didPressFFVELogo()
}

final class NewsViewModel {
    
    private weak var delegate: NewsDelegate?
    
    private var repository: NewsRepositoryType
    
    private var videoItems: [VideoItem]? {
        didSet {
            if let array = videoItems {
            videos?(array)
            indicatorState?(false)
            tableState?(true)
            }
        }
    }
    
    var videos : (([VideoItem]) -> Void)?
    
    var indicatorState: ((Bool) -> Void)?
    
    var tableState: ((Bool) -> Void)?
    
    var loadVideo: ((String) -> Void)?
    
    var webViewHidden: ((Bool) -> Void)?
    
    init(delegate: NewsDelegate, repository: NewsRepositoryType) {
        self.delegate = delegate
        self.repository = repository
    }
    
    func viewDidAppear() {
        indicatorState?(true)
        tableState?(false)
        webViewHidden?(true)
        repository.getEvents(completion: { (result) in
            switch result {
            case .success(value: let
                array):
                self.videoItems = array
            case .error:
                print("error")
            }
        })
    }
    
    func didSelect(video: VideoItem) {
        loadVideo?(video.videoId)
    }
    
    func beginPlaying() {
        webViewHidden?(false)
    }
    
    func didPressInfoLogo() {
        delegate?.didPressFFVELogo()
    }
}
