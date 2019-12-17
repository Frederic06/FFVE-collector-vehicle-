//
//  NewsRepositoryTests.swift
//  FFVETests
//
//  Created by Margarita Blanc on 16/12/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

@testable import FFVE
import XCTest

class NewsRepositoryTests: XCTestCase {
    
    func testGivenANewsRepositoryWhenCallingGetLanguageListLanguageItemIsCorrectlyReturnedToViewModel() {
        
        guard let path = Bundle(for: NewsRepositoryTests.self).path(forResource: "FakeVideoData", ofType: "json") else { return }
        
        let url = URL(fileURLWithPath: path)
        
        let networkMock = MockNetworkRequest(url: url)
        
        let newsRepository = NewsRepository(network: networkMock)
        
        let videos: [VideoItem] = [(VideoItem(mediumSnippet: "https://i.ytimg.com/vi/vTuH4lhbnNs/mqdefault.jpg", highSnipper: "https://i.ytimg.com/vi/vTuH4lhbnNs/hqdefault.jpg", publishedAt: "2019-11-25T06:37:33.000Z", title: "Lancement opération Lieux de mémoire automobile par la FFVE", description: "A l'occasion du salon Epoqu'Auto à Lyon le 9 novembre, Jean Louis Blanc, Président de la FFVE a lancé l'opération Lieux de mémoire de l'automobile en ...", videoId: "vTuH4lhbnNs", kind: "youtube#video"))]
        
        let expectation1 = self.expectation(description: "Returned without error")
        
        let expectation2 = self.expectation(description: "Returned correct VideoItem Array")
        
        newsRepository.getEvents(completion: { (result) in
            
            switch result {
            case .success(value: let news):
                print("¨PIZADAADADAPIZDA")
                print(news)
                XCTAssertNotNil(news)
                expectation1.fulfill()
                
                XCTAssertEqual(news, videos)
                expectation2.fulfill()
                
                
            default:
                print("not ok")
                
            }
        })
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGivenANewsRepositoryWhenCallingGetLanguageListErrorReturned() {
        
        guard let path = Bundle.main.path(forResource: "FakeVideoDataWrong", ofType: "json") else { return }
        
        let url = URL(fileURLWithPath: path)
        
        let networkMock = MockNetworkRequest(url: url)
        
        let newsRepository = NewsRepository(network: networkMock)
        
        let expectation1 = self.expectation(description: "Returned error")
        
        newsRepository.getEvents(completion: { (result) in
            
            switch result {
            case .error(description: let error):
                XCTAssertNotNil(error)
                expectation1.fulfill()
                
                
            default:
                print("not ok")
                
            }
        })
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
}

