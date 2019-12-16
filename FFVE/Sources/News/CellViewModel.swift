//
//  CellViewModel.swift
//  FFVE
//
//  Created by Margarita Blanc on 03/12/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import Foundation

final class CellViewModel {
    
    var video: VideoItem
    
    private let index: Int
    
    init(video: VideoItem, index: Int) {
        self.video = video
        self.index = index
    }
    
    var webViewHidden: ((Bool) -> Void)?
    
    var imageHidden: ((Bool) -> Void)?
    
    var videoItem: ((VideoItem) -> Void)?
    
    var play: (() -> Void)?
    
    func viewDidAppear() {
        videoItem?(video)
        play?()
        webViewHidden?(true)
        imageHidden?(false)
    }
    
    func PlayerReady() {
        webViewHidden?(false)
        imageHidden?(true)
    }
}
