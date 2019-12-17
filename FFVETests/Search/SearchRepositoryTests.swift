//
//  SearchRepositoryTests.swift
//  FFVETests
//
//  Created by Frédéric Blanc on 16/12/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

@testable import FFVE
import XCTest

class SearchRepositoryTests: XCTestCase {
    
    func testGivenAEventRepositoryWhenCallingGetLanguageListLanguageItemIsCorrectlyReturnedToViewModel() {
        
        guard let path = Bundle(for: NewsRepositoryTests.self).path(forResource: "FakeMemberData", ofType: "json") else { return }
        
        
        let url = URL(fileURLWithPath: path)
        
        let networkMock = MockNetworkRequest(url: url)
        
        let repository = SearchRepository(network: networkMock)
        
        let expectation1 = self.expectation(description: "Returned without error")
        
        let expectation2 = self.expectation(description: "Returned correct data")

        repository.getMembers(completion: { (result) in
            
            switch result {
            case .success(value: let events):
                XCTAssertNotNil(events)
                expectation1.fulfill()
                
                XCTAssertEqual(events.count, 1)
                expectation2.fulfill()
                
            default:
                print("not ok")
                
            }
        })
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGivenAEventRepositoryWhenCallingGetLanguageListErrorReturned() {
        
        guard let path = Bundle(for: NewsRepositoryTests.self).path(forResource: "FakeEventDataWrong", ofType: "json") else { return }
        
        let url = URL(fileURLWithPath: path)
        
        let networkMock = MockNetworkRequest(url: url)
        
        let repository = EventsRepository(network: networkMock)
        
        let expectation1 = self.expectation(description: "Returned error")
        
        repository.getEvents(completion: { (result) in
            
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
