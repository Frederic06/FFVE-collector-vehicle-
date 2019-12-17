//
//  MockNetworkRequest.swift
//  FFVETests
//
//  Created by Margarita Blanc on 16/12/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

@testable import FFVE
import Foundation

class MockNetworkRequest: NetworkRequestType {
    
    var urlJson: URL
    
    let error: MyError = .basicError
    
    init(url: URL) {
        self.urlJson = url
    }
    
    func request<T>(type: T.Type, url: URL, completion: @escaping (Result<T>) -> Void) where T: Decodable {
        do {
            let data = try Data(contentsOf: urlJson)
            
            let jsonDecoder = JSONDecoder()
            guard let decodedData = try? jsonDecoder.decode(type.self, from: data ) else {  completion(.error(description: error)); return }
            completion(.success(value: decodedData))
        }
        catch {
            completion(.error(description: error))
        }
    }
}
