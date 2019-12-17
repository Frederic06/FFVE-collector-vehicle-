//
//  EventDetailViewModelTests.swift
//  FFVETests
//
//  Created by Frédéric Blanc on 16/12/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

@testable import FFVE
import XCTest

final class EventDetailViewModelTests: XCTestCase {
    
    func testGivenADetailViewModelAndSearchViewModelWhenViewDidAppearPropertiesCorrectlyReturned() {
        let delegate = MockeEventDelegate()
        
        let event = EventItem(title: "Toto la nuit", description: "La première manifestation de toto", longDescription: "La première manifestation de toto ce 1er juin à Villefranche", image: "toto.jpg", locationName: "toto sur mer", firstDate: Date(), lastDate: Date(), thumbnail: "", eventUrl: "", longitude: 40912, latitude: 40912)
        
        
        let viewModel = EventDetailViewModel(delegate: delegate, event: event)
        
        let expectation1 = self.expectation(description: "All properties ok")
        viewModel.viewDidAppear()
        
        viewModel.mapHidden = { state in
            XCTAssertNotNil(state)
        }
        
        
        viewModel.eventItem = { item in
            XCTAssertEqual(item, event)
        }
        
        expectation1.fulfill()
        
        viewModel.viewDidAppear()
        viewModel.didPressInfo()
        viewModel.saveInCalendar()
        waitForExpectations(timeout: 2.0, handler: nil)
    }
}
