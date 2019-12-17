//
//  FFVEInfoViewModelTests.swift
//  FFVETests
//
//  Created by Frédéric Blanc on 16/12/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

@testable import FFVE
import XCTest

final class FFVEInfoViewModelTests: XCTestCase {

     func testGivenAHomeSearchViewModelTestsAndSearchRepositoryAndSearchViewModelWhenViewDidAppearPropertiesCorrectlyReturned() {
        let delegate = MockCoordinatorDelegate()
        let viewModel = FFVEInfoViewModel(function: .events, delegate: delegate)
        
        let expectedArray: [Button] = [.history, .inscriptions, .dev]
        
        let expectedResult = ["Histoire de la fédération","Conditions générales","A propos du développeur"]
        
                        let expectation1 = self.expectation(description: "Returned properties after View Did Load")
        
                let expectation2 = self.expectation(description: "Returned propertie buttonsTitle after viewDidAppear")
        
                        let expectation3 = self.expectation(description: "Returned propertie functionDescriptionText after View Did Appear")
        
                                let expectation4 = self.expectation(description: "Returned propertie openWebPage after View Did Appear")
        

        
        
        

        
        viewModel.buttons = { buttons in
             XCTAssertEqual(buttons, expectedArray)
            expectation1.fulfill()
        }
        
        viewModel.buttonsTitle = { text in
            XCTAssertEqual(text, expectedResult)
            expectation2.fulfill()
        }
        
        viewModel.functionDescriptionText = { text in
            XCTAssertEqual(text, "Le calendrier présente dans un ordre chronologique les événements auxquels participera la Fédération Française des Véhicules d'Epoque, cliquez sur un événement pour obtenir sa description")
            expectation3.fulfill()
        }
        
        viewModel.openWebPage = { text in
                   XCTAssertEqual(text, "https://frederic06.github.io/Demo/")
                   expectation4.fulfill()
               }
        
        viewModel.didPressX()
        viewModel.didPress(button: .dev)
        viewModel.viewDidAppear()
        waitForExpectations(timeout: 2.0, handler: nil)
        
    }
    
    func testGivenAaHomeSearchViewModelTestsAndSearchRepositoryAndSearchViewModelWhenViewDidAppearPropertiesCorrectlyReturned() {
        
    let delegate = MockCoordinatorDelegate()
    let viewModel = FFVEInfoViewModel(function: .events, delegate: delegate)
        
                                        let expectation5 = self.expectation(description: "Returned propertie openWebPage after View Did Appear")
        
        
        viewModel.openWebPage = { text in
                   XCTAssertEqual(text, "https://www.ffve.org/Histoire_de_la_FFVE")
                   expectation5.fulfill()
               }
        viewModel.didPress(button: .history)
    viewModel.viewDidAppear()
           waitForExpectations(timeout: 2.0, handler: nil)

    }
    
    func testGivenAaHomeSearchViewModelTestsAndSearchRepositoryAndSearchViewModelWhsenViewDidAppearPropertiesCorrectlyReturned() {
        
    let delegate = MockCoordinatorDelegate()
    let viewModel = FFVEInfoViewModel(function: .events, delegate: delegate)
        
                                        let expectation6 = self.expectation(description: "Returned propertie openWebPage after View Did Appear")
        
        
        viewModel.openWebPage = { text in
                   XCTAssertEqual(text, "https://www.ffve.org/Comment_adherer_a_la_FFVE")
                   expectation6.fulfill()
               }
        viewModel.didPress(button: .inscriptions)
    viewModel.viewDidAppear()
           waitForExpectations(timeout: 2.0, handler: nil)

    }
}




//var buttonsTitle: (([String]) -> Void)?
//
//var buttons: (([Button]) -> Void)?
//
//var functionDescriptionText: ((String) -> Void)?
//
//var functionCase: FunctionCase
//
//var openWebPage: ((String) -> Void)?
