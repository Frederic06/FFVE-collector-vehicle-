//
//  Network.swift
//  FFVE
//
//  Created by Margarita Blanc on 04/11/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import Foundation
import Alamofire

enum NetworkError: Error {
    case unknown
}

enum Result<T> {
    case success(value: T)
    case error(description: Error)
}

enum RequestType {
    case network
    case persistence
}

protocol NetworkRequestType {
    func request<T>(type: T.Type, url: URL, completion: @escaping (Result<T>) -> Void) where T: Decodable
}

final class NetworkRequest: NetworkRequestType {
    
    private let jsonDecoder = JSONDecoder()
    
    func request<T>(type: T.Type, url: URL, completion: @escaping (Result<T>) -> Void) where T : Decodable {
        AF.request(url).responseJSON { (response) in
            if let error = response.error {
                
                completion(.error(description: error))
            } else if let data = response.data {
                guard let recipes = try? self.jsonDecoder.decode(T.self, from: data) else {  print("decodeJson");return }
                completion(.success(value: recipes))
            } else {
                completion(.error(description: NetworkError.unknown))
            }
        }
    }
    
    private func decodeJSON<T>(type: T.Type, data: Data, completion: @escaping (T) -> Void) where T: Decodable {
        guard let decodedData = try? jsonDecoder.decode(type.self, from: data) else {return }
        completion(decodedData)
    }
}
