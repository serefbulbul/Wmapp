//
//  NetworkService.swift
//  Wmapp
//
//  Created by Seref Bulbul on 6.02.2019.
//  Copyright © 2019 Seref Bulbul. All rights reserved.
//

import Foundation

private enum NetworkConstants {
    
    static let baseUrl = "https://s3-us-west-2.amazonaws.com"
    
}

protocol NetworkServiceProtocol {
    
    typealias NetworkSuccessCompletionHandler<T: Any> = (_ object: T) -> Void
    typealias NetworkFailureCompletionHandler = (_ error: ErrorModel) -> Void
    
    static var instance: NetworkServiceProtocol { get }
    
}

final class NetworkService: NetworkServiceProtocol {
    
    static var instance: NetworkServiceProtocol = NetworkService()
    
    private init() { }
    
}
