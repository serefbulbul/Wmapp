//
//  NetworkService.swift
//  Wmapp
//
//  Created by Seref Bulbul on 6.02.2019.
//  Copyright © 2019 Seref Bulbul. All rights reserved.
//

import Foundation

private enum NetworkConstants {

    static let baseUrl = "https://s3-us-west-2.amazonaws.com/"

}

protocol NetworkServiceProtocol {

    typealias NetworkSuccessCompletionHandler<T: Any> = (_ object: T) -> Void
    typealias NetworkFailureCompletionHandler = (_ error: ErrorModel) -> Void

    static var instance: NetworkServiceProtocol { get }
    
    func getVehicles(success: @escaping NetworkSuccessCompletionHandler<VehiclesData>, failure: @escaping NetworkFailureCompletionHandler)

}

final class NetworkService: NetworkServiceProtocol {

    static var instance: NetworkServiceProtocol = NetworkService()

    private init() { }

    func getVehicles(success: @escaping NetworkSuccessCompletionHandler<VehiclesData>, failure: @escaping NetworkFailureCompletionHandler) {
        let urlString = "\(NetworkConstants.baseUrl)wunderbucket/locations.json"

        let request = NSMutableURLRequest(url: NSURL(string: urlString)! as URL)
        request.httpMethod = "GET"

        DispatchQueue.main.async {
            let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
                if let error = error {
                    if let error = error as NSError? {
                        failure(ErrorModel(errorCode: error.code, errorMessage: error.localizedDescription))
                    } else {
                        failure(ErrorModel(errorCode: nil, errorMessage: error.localizedDescription))
                    }

                    return
                }

                if let data = data, let vehiclesData = WMCoder.decode(VehiclesData.self, from: data) {
                    success(vehiclesData)
                } else {
                    failure(ErrorModel(errorCode: nil, errorMessage: error?.localizedDescription))
                }
            }

            task.resume()
        }
    }

}
