//
//  Service.swift
//  santander-test-clean-swift
//
//  Created by Cesar Giupponi Paiva on 12/04/19.
//  Copyright © 2019 Cesar Paiva. All rights reserved.
//

import Foundation

import UIKit
import Foundation

class Service<T : Codable> {
    
    typealias Completion = ((T)-> Void)
    typealias Failure = ((String)-> Void)
    
    private var url: URL
    
    init(url: String) {
        self.url = URL(string: url)!
    }
    
    func request(httpMethod: String, parameters: [String: Any]?, completion: @escaping Completion, failure: @escaping Failure) {
        var urlRequest = URLRequest(url: self.url)
        urlRequest.httpMethod = httpMethod
        urlRequest.allHTTPHeaderFields = ["Content-Type" : "application/json"]
        if httpMethod == "POST" {
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: parameters ?? nil!, options: [])
        }
        URLSession.shared.dataTask(with: urlRequest, completionHandler: {data, response, error in
            if error == nil {
                do {
                    guard let data = data else {
                        return
                    }
                    let json = try JSONDecoder().decode(T.self, from: data)
                    
                    DispatchQueue.main.async {
                        completion(json)
                    }
                } catch {
                    DispatchQueue.main.async {
                        failure(error.localizedDescription)
                    }
                }
            } else {
                failure("error: \(String(describing: error))")
            }
        }).resume()
    }
}
