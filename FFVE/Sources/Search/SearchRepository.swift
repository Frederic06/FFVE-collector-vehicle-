//
//  ResearchRepository.swift
//  FFVE
//
//  Created by Margarita Blanc on 31/10/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import Foundation

final class SearchRepository {
    private let network: Network
    
    private let route = Route()
    
    // MARK - Init
    
    init(network: Network) {
        self.network = network
    }
    
    // MARK - Public methods
    
    func checkIfFavorite( completion: ([Member]) -> Void) {
    }
}
