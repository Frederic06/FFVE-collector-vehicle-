//
//  ClubModel.swift
//  FFVE
//
//  Created by Margarita Blanc on 04/11/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import Foundation

enum MemberType {
    case Club, Museum, Professional
}

struct Member {
    var memberType: MemberType
    var name: String
    var logo: String?
    var president: String
    var adress: String
    var postCode: String
    var city: String
    var department: String
    var country: String
    var carType: String?
    var phoneNumber: [Int]?
    var mailAdress: [String]?
    var webSite: String?
}
