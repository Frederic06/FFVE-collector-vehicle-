//
//  NewsViewModelTests.swift
//  FFVETests
//
//  Created by Margarita Blanc on 16/12/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

@testable import FFVE
import XCTest

class NewsViewModelTests: XCTestCase {
    
    func testGivenASearchRepositoryAndSearchViewModelWhenViewDidAppearPropertiesCorrectlyReturned() {
        let delegate = MockNewsDelegate()
        
        let videoArray: [VideoItem] = [(VideoItem(mediumSnippet: "https://i.ytimg.com/vi/vTuH4lhbnNs/mqdefault.jpg", highSnipper: "https://i.ytimg.com/vi/vTuH4lhbnNs/hqdefault.jpg", publishedAt: "2019-11-25T06:37:33.000Z", title: "Lancement opération Lieux de mémoire automobile par la FFVE", description: "A l'occasion du salon Epoqu'Auto à Lyon le 9 novembre, Jean Louis Blanc, Président de la FFVE a lancé l'opération Lieux de mémoire de l'automobile en ...", videoId: "vTuH4lhbnNs", kind: "youtube#video"))]
        
        let repository = MockNewsRepository(videos: videoArray)
        let viewModel = NewsViewModel(delegate: delegate, repository: repository)
        
        let expectation1 = self.expectation(description: "Returned properties after View Did Load")
        
        let expectation2 = self.expectation(description: "Returned properties after View Did Load")
        
        let expectation3 = self.expectation(description: "Returned properties after View Did Load")
        
        viewModel.videos = { videos in
            XCTAssertEqual(videos, videoArray)
            expectation1.fulfill()
        }
        
        viewModel.webViewHidden = { state in
            XCTAssertEqual(state, true)
            expectation2.fulfill()
        }

        var indicatorPassageCounter = 0
        viewModel.indicatorState = { state in
            if indicatorPassageCounter == 0 {
                XCTAssertEqual(state, true)
                expectation3.fulfill()
            }
            indicatorPassageCounter+=1
        }
        
        viewModel.viewDidAppear()
        waitForExpectations(timeout: 2.0, handler: nil)
    }
    
    func testGivenASearchRepositoryAndViewControllerAndSearchViewModelWhenViewDidAppearPropertiesCorrectlyReturned() {
        let delegate = MockNewsDelegate()
        
        let videoArray: [VideoItem] = [(VideoItem(mediumSnippet: "https://i.ytimg.com/vi/vTuH4lhbnNs/mqdefault.jpg", highSnipper: "https://i.ytimg.com/vi/vTuH4lhbnNs/hqdefault.jpg", publishedAt: "2019-11-25T06:37:33.000Z", title: "Lancement opération Lieux de mémoire automobile par la FFVE", description: "A l'occasion du salon Epoqu'Auto à Lyon le 9 novembre, Jean Louis Blanc, Président de la FFVE a lancé l'opération Lieux de mémoire de l'automobile en ...", videoId: "vTuH4lhbnNs", kind: "youtube#video"))]
        
        let video: VideoItem = VideoItem(mediumSnippet: "https://i.ytimg.com/vi/vTuH4lhbnNs/mqdefault.jpg", highSnipper: "https://i.ytimg.com/vi/vTuH4lhbnNs/hqdefault.jpg", publishedAt: "2019-11-25T06:37:33.000Z", title: "Lancement opération Lieux de mémoire automobile par la FFVE", description: "A l'occasion du salon Epoqu'Auto à Lyon le 9 novembre, Jean Louis Blanc, Président de la FFVE a lancé l'opération Lieux de mémoire de l'automobile en ...", videoId: "vTuH4lhbnNs", kind: "youtube#video")
        
        let repository = MockNewsRepository(videos: videoArray)
        let viewModel = NewsViewModel(delegate: delegate, repository: repository)
        
        let expectation1 = self.expectation(description: "Returned properties after View Did Load")
        
        
        viewModel.loadVideo = { id in
            XCTAssertEqual(id, "vTuH4lhbnNs")
        }
        
        expectation1.fulfill()
        viewModel.viewDidAppear()
        viewModel.didSelect(video: video)
        viewModel.beginPlaying()
        viewModel.didPressInfoLogo()
        waitForExpectations(timeout: 2.0, handler: nil)
    }
    
    func testGivenASearchRepositoryWithBadDataAndSearchViewModelWhenViewDidAppearPropertiesCorrectlyReturned() {
        let delegate = MockNewsDelegate()
        
        let repository = MockNewsRepository(videos: nil)
        let viewModel = NewsViewModel(delegate: delegate, repository: repository)
        
        let expectation1 = self.expectation(description: "Returned properties after View Did Load")
        viewModel.viewDidAppear()
        
        viewModel.webViewHidden = { state in
            XCTAssertEqual(state, true)
        }
        
        expectation1.fulfill()
        viewModel.viewDidAppear()
        waitForExpectations(timeout: 2.0, handler: nil)
    }
}

