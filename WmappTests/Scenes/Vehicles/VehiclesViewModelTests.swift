//
//  VehiclesViewModelTests.swift
//  WmappTests
//
//  Created by Seref Bulbul on 8.02.2019.
//  Copyright © 2019 Seref Bulbul. All rights reserved.
//

@testable import Wmapp

import XCTest
import CoreLocation

class VehiclesViewModelTests: XCTestCase {
    
    let view = MockVehiclesView()
    var networkService = MockNetworkService()
    var viewModel: VehiclesViewModelProtocol!
    
    override func setUp() {
        super.setUp()
        
        viewModel = VehiclesViewModel(view: view, networkService: networkService)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testRequestVehiclesData_success() {
        let vehiclesData = VehiclesData(vehicles: [])
        vehiclesData.vehicles.append(VehicleData(name: "vehicleName", address: "vehicleAddress", coordinates: [1.0, 1.0, 1.0], engineType: EngineType.ce, fuel: 10, exterior: VehiclePartStatus.good, interior: VehiclePartStatus.good, vin: "vehicleVin"))
        
        networkService.vehiclesData = vehiclesData
        
        viewModel.requestVehicles()
        
        assert(viewModel.vehicles.count == 1, "Vehicles count should be 1.")
        assert(view.updateVehiclesCallCount == 1, "view.updateVehicles should be called 1 time.")
        assert(view.showAlertCallCount == 0, "view.showAlert should not be called.")
    }
    
    func testRequestVehiclesData_failure() {
        viewModel.requestVehicles()
        
        assert(viewModel.vehicles.count == 0, "Vehicles should be empty.")
        assert(view.updateVehiclesCallCount == 0, "updateVehiclesCallCount should not be called.")
        assert(view.showAlertCallCount == 1, "view.showAlert should be called 1 times.")
    }
}
