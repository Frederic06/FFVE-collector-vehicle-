//
//  MockSearchRepository.swift
//  FFVETests
//
//  Created by Frédéric Blanc on 16/12/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

@testable import FFVE
import XCTest

final class MockSearchRepository: SearchRepositoryType{
    
    
    let members: [MemberItem]?
    
    init(members: [MemberItem]) {
        self.members = members
    }
    
    func getMembers(completion: @escaping (Result<[MemberItem]>) -> Void) {
        if members != nil {
            completion(.success(value: members!))
        }
    }
}
