//
//  MockNetworkService.swift
//  WmappTests
//
//  Created by Seref Bulbul on 8.02.2019.
//  Copyright © 2019 Seref Bulbul. All rights reserved.
//

@testable import Wmapp

import Foundation

class MockNetworkService: NetworkServiceProtocol {

    public var vehiclesData: VehiclesData?
    public var errorCode: Int?
    public var errorMessage: String?

    static var instance: NetworkServiceProtocol = MockNetworkService()

    func getVehicles(success: @escaping (VehiclesData) -> (), failure: @escaping NetworkFailureCompletionHandler) {
        if let vehiclesData = vehiclesData {
            success(vehiclesData)
        } else {
            failure(ErrorModel(errorCode: errorCode, errorMessage: errorMessage))
        }
    }

}
