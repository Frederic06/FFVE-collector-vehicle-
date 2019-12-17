//
//  HomeSearchViewModelTests.swift
//  FFVETests
//
//  Created by Frédéric Blanc on 16/12/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

@testable import FFVE
import XCTest

final class HomeSearchViewModelTests: XCTestCase {
    
    func testGivenAHomeSearchViewModelTestsAndSearchRepositoryAndSearchViewModelWhenViewDidAppearPropertiesCorrectlyReturned() {
        let delegate = MockSearchDelegate(type: .club, alert: true)
        let viewModel = HomeSearchViewModel(delegate: delegate)
        
        let dataSource = DepartmentPickerDataSource()
        
        let expectation1 = self.expectation(description: "All properties ok")
        
        let expectedLabel: String = ("""
            Deux possibilités:

        - Tappez un nom de ville ou de membre dans la barre de recherche supérieure

        - Suivez le chemin de recherche classique via les boutons de la page principale
        """)
        
        
        viewModel.titleDescriptionText = { text in
            XCTAssertEqual(text, "Instructions pour la recherche")
        }
        
        viewModel.firstButtonText = { text in
            XCTAssertEqual(text, "     1 -> Spécifiez le type d'adhérent")
        }
        
        viewModel.thirdButtonText = { text in
            XCTAssertEqual(text, "     3 -> Choisissez un département")
        }
        
        viewModel.searchButtonText = { text in
            XCTAssertEqual(text, "Lancez la recherche !!")
        }
        
        viewModel.descriptionLabelText = { text in
            XCTAssertEqual(text,expectedLabel)
            
        }
        viewModel.titleDescriptionHidden = { text in
            XCTAssertNotNil(text)
            
        }
        viewModel.descriptionLabelHidden = { text in
            XCTAssertNotNil(text)
            
        }
        viewModel.firstButtonHidden = { text in
            XCTAssertNotNil(text)
            
        }
        viewModel.secondButtonHidden = { text in
            XCTAssertNotNil(text)
            
        }
        viewModel.thirdButtonHidden = { text in
            XCTAssertNotNil(text)
            
        }
        viewModel.searchButtonHidden = { text in
            XCTAssertNotNil(text)
            
        }
        viewModel.firstLabelHidden = { text in
            XCTAssertNotNil(text)
            
        }
        viewModel.secondLabelHidden = { text in
            XCTAssertNotNil(text)
            
        }
        viewModel.thirdLabelHidden = { text in
            XCTAssertNotNil(text)
            
        }
        
        
        expectation1.fulfill()
        viewModel.didPressMemberTypeFilter(datasource: dataSource)
        viewModel.didPressSearch()
        viewModel.didPressFilter(from: .thirdButton, dataSource: dataSource)
        viewModel.didPressInfoLogo()
        viewModel.didPressSearchBar()
        viewModel.didSelect(item: "01 : Ain")
        viewModel.viewDidAppear()
        waitForExpectations(timeout: 2.0, handler: nil)
    }
    func testGivenAHomeSearchViewModelTestsAndSearchRepositoryAndSearchViewMoadelWhenViewDidAppearPropertiesCorrectlyReturned() {
        let delegate = MockSearchDelegate(type: .auto(.alphaRomeo), alert: true)
        let viewModel = HomeSearchViewModel(delegate: delegate)
        
        let dataSource = DepartmentPickerDataSource()
        
        let expectation1 = self.expectation(description: "All properties ok")
        
        expectation1.fulfill()
        viewModel.didPressMemberTypeFilter(datasource: dataSource)
        viewModel.didPressSearch()
        viewModel.didPressFilter(from: .thirdButton, dataSource: dataSource)
        viewModel.didPressInfoLogo()
        viewModel.didPressSearchBar()
        viewModel.didSelect(item: "")
        viewModel.viewDidAppear()
        waitForExpectations(timeout: 2.0, handler: nil)
    }
    
    func testGivenAHomeSearchViewModelTestsAndSearchRepositoryAndSearchViewMoadzelWhenViewDidAppearPropertiesCorrectlyReturned() {
        let delegate = MockSearchDelegate(type: .professional(.accessoiresDivers), alert: true)
        let viewModel = HomeSearchViewModel(delegate: delegate)
        
        let dataSource = DepartmentPickerDataSource()
        
        let expectation1 = self.expectation(description: "All properties ok")
        
        expectation1.fulfill()
        viewModel.didPressMemberTypeFilter(datasource: dataSource)
        viewModel.didPressSearch()
        viewModel.didPressFilter(from: .thirdButton, dataSource: dataSource)
        viewModel.didPressInfoLogo()
        viewModel.didPressSearchBar()
        viewModel.didSelect(item: "01 : Ain")
        viewModel.viewDidAppear()
        waitForExpectations(timeout: 2.0, handler: nil)
    }
    
    func testGivenAHomeSearchViewModelTestsAndSearchRepositoryAndSearchViewMoadzzelWhenViewDidAppearPropertiesCorrectlyReturned() {
        let delegate = MockSearchDelegate(type: .museum, alert: true)
        let viewModel = HomeSearchViewModel(delegate: delegate)
        
        let dataSource = DepartmentPickerDataSource()
        
        let expectation1 = self.expectation(description: "All properties ok")
        
        expectation1.fulfill()
        viewModel.didPressMemberTypeFilter(datasource: dataSource)
        viewModel.didPressSearch()
        viewModel.didPressFilter(from: .thirdButton, dataSource: dataSource)
        viewModel.didPressInfoLogo()
        viewModel.didPressSearchBar()
        viewModel.didSelect(item: "01 : Ain")
        viewModel.viewDidAppear()
        waitForExpectations(timeout: 2.0, handler: nil)
    }
}
