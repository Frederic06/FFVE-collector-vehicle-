//
//  Member.swift
//  FFVE
//
//  Created by Frédéric Blanc on 13/11/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import Foundation

struct Member: Decodable {
    let data: [Data]
    
    struct Data: Decodable {
        let category: String
        let name: String
        let address1: String
        let address2: String
        let postal_code: String
        let department_no: String
        let department: String
        let city: String
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
    }
}
