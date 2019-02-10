//
//  MockVehiclesView.swift
//  WmappTests
//
//  Created by Seref Bulbul on 8.02.2019.
//  Copyright © 2019 Seref Bulbul. All rights reserved.
//

@testable import Wmapp

import Foundation

class MockVehiclesView: VehiclesViewProtocol {
    
    public var updateVehiclesCallCount = 0
    public var showAlertCallCount = 0
    
    func updateVehicles() {
        updateVehiclesCallCount += 1
    }
    
    func showAlert(message: String?) {
        showAlertCallCount += 1
    }
    
}
