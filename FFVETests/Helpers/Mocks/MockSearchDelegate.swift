//
//  MockSearchDelegate.swift
//  FFVETests
//
//  Created by Frédéric Blanc on 16/12/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

@testable import FFVE
import XCTest

final class MockSearchDelegate: SearchDelegate {
    func alertNoMember() {
    }
    
    let memberType: MemberType?
    let alertChoice: Bool?
    
    init(type: MemberType?, alert: Bool) {
        self.memberType = type
        self.alertChoice = alert
    }
    func seeMembers(filters: FiltersItem) {

    }
    
    func memberChoiceAlert(closure: @escaping (MemberType?) -> Void) {
        if memberType != nil {
            closure(memberType!)
        } else {
            closure(nil)
        }
    }
    
    func clubChoiceAlert(closure: @escaping (MemberType?) -> Void) {
        if memberType != nil {
            closure(memberType!)
        } else {
            closure(nil)
        }
    }
    
    func alert(for filter: Filter, dataSource: DepartmentPickerDataSource, didPressOk: @escaping (Bool?) -> Void) {
        if alertChoice != nil {
            didPressOk(alertChoice)
        } else {
            didPressOk(nil)
        }
    }
    
    func didTapOnSearchBar() {
        
    }
    
    func seeMemberDetail(member: MemberItem) {
        
    }
    
    func alert(type: AlertType) {
        
    }
    
    func dismissVC() {
        
    }
    
    func didPressFFVELogo() {
        
    }
}
