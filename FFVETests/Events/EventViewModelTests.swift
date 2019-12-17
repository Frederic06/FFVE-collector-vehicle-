//
//  EventViewModelTests.swift
//  FFVETests
//
//  Created by Frédéric Blanc on 16/12/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

@testable import FFVE
import XCTest

final class EventViewModelTests: XCTestCase {
    func testGivenASearchRepositoryAndSearchViewModelWhenViewDidAppearPropertiesCorrectlyReturned() {
           let delegate = MockeEventDelegate()
           
           let eventArray: [EventItem] = [(EventItem(title: "Toto la nuit", description: "La première manifestation de toto", longDescription: "La première manifestation de toto ce 1er juin à Villefranche", image: "toto.jpg", locationName: "toto sur mer", firstDate: Date(), lastDate: Date(), thumbnail: "", eventUrl: "", longitude: 40912, latitude: 40912))]
           
        let repository = MockEventsRepository(events: eventArray)
           let viewModel = EventsViewModel(repository: repository, delegate: delegate)
           
           let expectation1 = self.expectation(description: "All properties ok")
           viewModel.viewDidAppear()
           
           viewModel.tableHidden = { state in
               XCTAssertNotNil(state)
           }
        
        viewModel.activityIsHidden = { state in
            XCTAssertNotNil(state)
        }
        
        viewModel.eventItems = { items in
            XCTAssertEqual(items, eventArray)
        }
        
        expectation1.fulfill()
        

        
        
        viewModel.viewDidAppear()
        waitForExpectations(timeout: 2.0, handler: nil)
    }
    
    func testGivenAEventRepositoryAndEventViewModelWhenViewDidAppearAndRepositoryCalledPropertiesCorrectlyReturned() {
           let delegate = MockeEventDelegate()
           
           let eventArray: [EventItem]? = nil
           
        let repository = MockEventsRepository(events: eventArray)
        
        
           let viewModel = EventsViewModel(repository: repository, delegate: delegate)
           
           let expectation1 = self.expectation(description: "Returned properties after View Did Load")
           viewModel.viewDidAppear()
           
           viewModel.tableHidden = { videos in
               XCTAssertNotNil(videos)
            
           }
        
        viewModel.activityIsHidden = { videos in
            XCTAssertNotNil(videos)
        }
        
        expectation1.fulfill()
        

        
        
        viewModel.viewDidAppear()
        waitForExpectations(timeout: 2.0, handler: nil)
    }
    
    func testGivenAEventRepositoryAndEventViewModelWhenViewDidAppearAndRepositoryCalledWithFakePropertiesCorrectlyReturned() {
           let delegate = MockeEventDelegate()
           
           let eventArray: [EventItem]? = nil
           
        let repository = MockEventsRepository(events: eventArray)
        
        
           let viewModel = EventsViewModel(repository: repository, delegate: delegate)
           
           let expectation1 = self.expectation(description: "Returned properties after View Did Load")
           viewModel.viewDidAppear()
           
           viewModel.tableHidden = { videos in
               XCTAssertNotNil(videos)
            
           }
        
        viewModel.activityIsHidden = { videos in
            XCTAssertNotNil(videos)
        }
        
        expectation1.fulfill()
        

        
        viewModel.viewDidAppear()
        waitForExpectations(timeout: 2.0, handler: nil)
    }
    
    func testGivenDidChooseEventAEventRepositoryAndSearchViewModelWhenViewDidAppearPropertiesCorrectlyReturned() {
           let delegate = MockeEventDelegate()
           
           let eventArray: [EventItem] = [(EventItem(title: "Toto la nuit", description: "La première manifestation de toto", longDescription: "La première manifestation de toto ce 1er juin à Villefranche", image: "toto.jpg", locationName: "toto sur mer", firstDate: Date(), lastDate: Date(), thumbnail: "", eventUrl: "", longitude: 40912, latitude: 40912))]
        
        let event = EventItem(title: "Toto la nuit", description: "La première manifestation de toto", longDescription: "La première manifestation de toto ce 1er juin à Villefranche", image: "toto.jpg", locationName: "toto sur mer", firstDate: Date(), lastDate: Date(), thumbnail: "", eventUrl: "", longitude: 40912, latitude: 40912)
           
        let repository = MockEventsRepository(events: eventArray)
           let viewModel = EventsViewModel(repository: repository, delegate: delegate)
           
           let expectation1 = self.expectation(description: "All properties ok")
           viewModel.viewDidAppear()
           
           viewModel.tableHidden = { state in
               XCTAssertNotNil(state)
           }
        
        viewModel.activityIsHidden = { state in
            XCTAssertNotNil(state)
        }
        
        viewModel.eventItems = { items in
            XCTAssertEqual(items, eventArray)
        }
        
        expectation1.fulfill()
        

        viewModel.didChooseEvent(event: event)
        viewModel.didPressInfoLogo()
        
        viewModel.viewDidAppear()
        waitForExpectations(timeout: 2.0, handler: nil)
    }
    
}

//enum MyError: Error {
//    case runtimeError(String)
//    case basicError
//}
