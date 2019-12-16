//
//  ClubModel.swift
//  FFVE
//
//  Created by Margarita Blanc on 04/11/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import Foundation
import MapKit

struct MemberItem: Equatable {
    let category: String
    var name: String
    let address1: String
    let address2: String
    let postal_code: String
    let department_no: String
    let department: String
    var city: String
    let country: String
    let email: String
    let site: String
    let tel1: String
    let tel2: String
    let n_intern: String
    let college: String
    let status: String
    let atype: String
    let pres_genre : String
    let pres_prenom: String
    let pres_nom: String
    var longitude: String?
    var latitude: String?
    
    static func ==(lhs: MemberItem, rhs: MemberItem) -> Bool {
        return lhs.category == rhs.category && lhs.name == rhs.name && lhs.address1 == rhs.address1 && lhs.address2 == rhs.address2 && lhs.postal_code == rhs.postal_code && lhs.department_no == rhs.department_no && lhs.department == rhs.department && lhs.city == rhs.city && lhs.country == rhs.country && lhs.email == rhs.email && lhs.site == rhs.site && lhs.tel1 == rhs.tel1 && lhs.tel2 == rhs.tel2 && lhs.n_intern == rhs.n_intern && lhs.college == rhs.college && lhs.status == rhs.status && lhs.atype == rhs.atype && lhs.pres_genre == rhs.pres_genre && lhs.pres_prenom == rhs.pres_prenom && lhs.pres_nom == rhs.pres_nom && lhs.longitude == rhs.longitude && lhs.latitude == rhs.latitude
    }
}

enum CenterPointCase: Double {
    case city = 10000, department = 20000, none = 100000
}

struct City: Hashable {
    var cityName: String
    var departmentNumber: String
}
