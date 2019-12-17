//
//  SearchResultViewModelTests.swift
//  FFVETests
//
//  Created by Frédéric Blanc on 16/12/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

@testable import FFVE
import XCTest

final class SearchResultViewModelTests: XCTestCase {

     func testGivenASearchResultViewModelTestsAndSearchRepositoryAndSearchViewModelWhenViewDidAppearPropertiesCorrectlyReturned() {
        let delegate = MockSearchDelegate(type: .club, alert: true)
                let members: [MemberItem] = [MemberItem(category: "Automobiles", name: "17 Retro Passion", address1: "12 rue des varennes", address2: "", postal_code: "17400", department_no: "17", department: "Charente-Maritime", city: "LES EGLISES d'ARGENTEUIL", country: "France", email: "joscia.martin@sfr.fr", site: "", tel1: "05 46 32 56 00", tel2: "", n_intern: "619", college: "Marques", status: "1", atype: "Club marques", pres_genre: "Mme", pres_prenom: "Joscia", pres_nom: "MARTIN", longitude: "", latitude: "")]
        
        let repository = MockSearchRepository(members: members)
         let expectation1 = self.expectation(description: "All properties ok")
        let filters = FiltersItem(type: .club, department: nil, city: nil)
        let viewModel = SearchResultsViewModel(delegate: delegate, repository: repository, filters: filters)
        
        viewModel.switchTitle = { text in
            XCTAssertEqual(text, "Liste / Carte")
        }
        viewModel.activityIndicatorIsHidden = { text in
            XCTAssertNotNil(text)
        }
        
        viewModel.tableHidden = { text in
            XCTAssertNotNil(text)
        }
        
                expectation1.fulfill()
        viewModel.didPressInfoLogo()
        viewModel.viewDidAppear()
//        viewModel.didSelectMember(member: member1)
//        viewModel.didClickOnMember(memberName: "17 Retro Passion")
        waitForExpectations(timeout: 2.0, handler: nil)
        
    }
}
