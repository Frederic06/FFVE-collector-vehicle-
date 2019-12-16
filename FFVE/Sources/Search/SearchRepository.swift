//
//  ResearchRepository.swift
//  FFVE
//
//  Created by Margarita Blanc on 31/10/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import Foundation
import Alamofire

protocol SearchRepositoryType {
    func getMembers(completion: @escaping (Result<[MemberItem]>) -> Void)
}

final class SearchRepository: SearchRepositoryType {
    
    private let network: NetworkRequestType
    
    private let route = Route()
    
    private let coordinates = Coordinates()
    
    // MARK - Init
    
    init(network: NetworkRequestType) {
        self.network = network
    }
    
    // MARK - Public methods

    func getMembers(completion: @escaping (Result<[MemberItem]>) -> Void) {
        guard let url = route.getURL(request: .members) else {return}
            
        network.request(type: Member.self, url: url) { (result) in
            switch result {
            case .success(value: let memberItem):
                let result: [MemberItem] = memberItem.data.map { return MemberItem(category: $0.category, name: $0.name, address1: $0.address1, address2: $0.address2, postal_code: $0.postal_code, department_no: $0.department_no, department: $0.department_no, city: $0.city, country: $0.country, email: $0.email, site: $0.site, tel1: $0.tel1, tel2: $0.tel2, n_intern: $0.n_intern, college: $0.college, status: $0.status, atype: $0.atype, pres_genre: $0.pres_genre, pres_prenom: $0.pres_prenom, pres_nom: $0.pres_nom, longitude: "", latitude: "")}
                completion(.success(value: result))
            case .error(description: let error):
                completion(.error(description: error))
            }
        }
    }
}
