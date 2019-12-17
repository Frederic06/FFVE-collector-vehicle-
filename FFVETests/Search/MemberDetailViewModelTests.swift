//
//  MemberDetailViewModelTests.swift
//  FFVETests
//
//  Created by Frédéric Blanc on 16/12/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

@testable import FFVE
import XCTest

final class MemberDetailViewModelTests: XCTestCase {

     func testGivenAMemberDetailViewModelTestsAndSearchRepositoryAndSearchViewModelWhenViewDidAppearPropertiesCorrectlyReturned() {
        let delegate = MockSearchDelegate(type: .club, alert: true)

        let member = MemberItem(category: "toto", name: "Jean Paul Itur", address1: "33 chemin des oies", address2: "", postal_code: "78102", department_no: "78", department: "Yvelines", city: "Poissy", country: "Wakanda", email: "jean.dodo@gmaio.fr", site: "", tel1: "09112123422", tel2: "", n_intern: "999", college: "Tala", status: "1", atype: "Voiture", pres_genre: "masc", pres_prenom: "Paul", pres_nom: "Etienne", longitude: "098821", latitude: "98832")
        
                let viewModel = MemberDetailViewModel(delegate: delegate, member: member)
        
                   let expectation1 = self.expectation(description: "All properties ok")
        
        viewModel.memberNameLabelText = { videos in
            XCTAssertEqual(videos, "Jean Paul Itur")
            
        }
        
        viewModel.memberTypeLabelText = { videos in
            XCTAssertEqual(videos, "Type de membre: Tala")
            
        }
        
        viewModel.presidentLabelText = { videos in
            XCTAssertEqual(videos, "Président: Etienne Paul")
            
        }
        
        viewModel.coordinatesLabelText = { videos in
            XCTAssertEqual(videos, """
            📞 \(member.tel1)
            ✉️ \(member.email)
            """)
            
        }
        viewModel.adressLabelText = { videos in
            XCTAssertEqual(videos, """
            \(member.address1)
            \(member.postal_code) \(member.city)
            """)
            
        }
        
        viewModel.memberItem = { videos in
            XCTAssertEqual(videos, member)
            
        }
        
        expectation1.fulfill()
        viewModel.didPressInfoLogo()
        viewModel.viewDidAppear()
        waitForExpectations(timeout: 2.0, handler: nil)
    }
}
