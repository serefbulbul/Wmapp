
//
//  MockMapView.swift
//  WmappTests
//
//  Created by Seref Bulbul on 12.02.2019.
//  Copyright © 2019 Seref Bulbul. All rights reserved.
//

@testable import Wmapp

import Foundation

class MockMapView: MapViewProtocol {
    
    public var centerMapOnLocationCallCount = 0
    public var deselectAndShowVehicleAnnotationsCallCount = 0
    public var hideVehicleAnnotationsCallCount = 0
    public var showAlertCallCount = 0
    
    func centerMapOnLocation(latitude: Double, longitude: Double) {
        centerMapOnLocationCallCount += 1
    }
    
    func deselectAndShowVehicleAnnotations() {
        deselectAndShowVehicleAnnotationsCallCount += 1
    }
    
    func hideVehicleAnnotations(exceptAnnotation: VehicleAnnotation) {
        hideVehicleAnnotationsCallCount += 1
    }
    
    func showAlert(message: String?) {
        showAlertCallCount += 1
    }
    
}
