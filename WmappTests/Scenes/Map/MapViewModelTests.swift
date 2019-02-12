//
//  MapViewModelTests.swift
//  WmappTests
//
//  Created by Seref Bulbul on 12.02.2019.
//  Copyright © 2019 Seref Bulbul. All rights reserved.
//

@testable import Wmapp

import XCTest

class MapViewModelTests: XCTestCase {

    let view = MockMapView()
    var viewModel: MapViewModelProtocol!

    override func setUp() {
        super.setUp()

        viewModel = MapViewModel(view: view, vehicles: [VehicleData](), selectedVehicleIndex: 0)
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func testVehiclesWillSet_success() {
        let vehicle = VehicleData(name: "vehicleName", address: "vehicleAddress", coordinates: [1.0, 1.0, 1.0], engineType: EngineType.ce, fuel: 10, exterior: VehiclePartStatus.good, interior: VehiclePartStatus.good, vin: "vehicleVin")
        
        viewModel = MapViewModel(view: view, vehicles: [vehicle], selectedVehicleIndex: 0)
        
        let vehicleAnnotations = [vehicle].map({ (vehicleData) -> VehicleAnnotation in
            VehicleAnnotation(vehicleData: vehicleData)
        })
        
        assert(viewModel.vehicleAnnotations.count == vehicleAnnotations.count, "vehicleAnnotations should have same count.")
        assert(viewModel.vehicleAnnotations[0].title == vehicleAnnotations[0].title, "First vehicleAnnotations should have same title.")
        assert(viewModel.vehicleAnnotations[0].subtitle == vehicleAnnotations[0].subtitle, "First vehicleAnnotations should have same subtitle.")
    }

    func testInitialSetup_successWithSelectedVehicleIndexAndEmptyVehiclesData() {
        viewModel = MapViewModel(view: view, vehicles: [VehicleData](), selectedVehicleIndex: 0)

        viewModel.initialSetup()

        assert(view.centerMapOnLocationCallCount == 0, "view.centerMapOnLocation should not be called.")
        assert(view.deselectAndShowVehicleAnnotationsCallCount == 1, "view.deselectAndShowVehicleAnnotations should be called 1 time.")
    }

    func testInitialSetup_successWithSelectedVehicleIndexAndNotEmptyVehiclesData() {
        var vehicles = [VehicleData]()
        vehicles.append(VehicleData(name: "vehicleName", address: "vehicleAddress", coordinates: [1.0, 1.0, 1.0], engineType: EngineType.ce, fuel: 10, exterior: VehiclePartStatus.good, interior: VehiclePartStatus.good, vin: "vehicleVin"))
        
        viewModel = MapViewModel(view: view, vehicles: vehicles, selectedVehicleIndex: 0)

        viewModel.initialSetup()

        assert(view.centerMapOnLocationCallCount == 1, "view.centerMapOnLocation should be called 1 time.")
        assert(view.deselectAndShowVehicleAnnotationsCallCount == 1, "view.deselectAndShowVehicleAnnotations should be called 1 time.")
    }

    func testInitialSetup_successWithoutSelectedVehicleIndex() {
        viewModel = MapViewModel(view: view, vehicles: [VehicleData](), selectedVehicleIndex: nil)

        viewModel.initialSetup()

        assert(view.centerMapOnLocationCallCount == 0, "view.centerMapOnLocation should not be called.")
        assert(view.deselectAndShowVehicleAnnotationsCallCount == 1, "view.deselectAndShowVehicleAnnotations should be called 1 time.")
    }
    
    func testDidTap_successWithSelectedAnnotation() {
        let vehicle = VehicleData(name: "vehicleName", address: "vehicleAddress", coordinates: [1.0, 1.0, 1.0], engineType: EngineType.ce, fuel: 10, exterior: VehiclePartStatus.good, interior: VehiclePartStatus.good, vin: "vehicleVin")
        
        let vehicleMarkerView = VehicleMarkerView(annotation: VehicleAnnotation(vehicleData: vehicle), reuseIdentifier: VehicleMarkerView.identifier)
        vehicleMarkerView.isSelected = true
        
        let gesture = UITapGestureRecognizer()
        
        vehicleMarkerView.addGestureRecognizer(gesture)
        
        viewModel.didTap(gesture: gesture)
        
        assert(view.deselectAndShowVehicleAnnotationsCallCount == 1, "view.deselectAndShowVehicleAnnotations should be called 1 time.")
    }
    
    func testDidTap_successWithNotSelectedAnnotation() {
        let vehicle = VehicleData(name: "vehicleName", address: "vehicleAddress", coordinates: [1.0, 1.0, 1.0], engineType: EngineType.ce, fuel: 10, exterior: VehiclePartStatus.good, interior: VehiclePartStatus.good, vin: "vehicleVin")
        
        let vehicleMarkerView = VehicleMarkerView(annotation: VehicleAnnotation(vehicleData: vehicle), reuseIdentifier: VehicleMarkerView.identifier)
        vehicleMarkerView.isSelected = false
        
        let gesture = UITapGestureRecognizer()
        
        vehicleMarkerView.addGestureRecognizer(gesture)
        
        viewModel.didTap(gesture: gesture)
        
        assert(vehicleMarkerView.isSelected == true, "vehicleMarkerView should be selected.")
        assert(view.hideVehicleAnnotationsCallCount == 1, "hideVehicleAnnotations should be called 1 time.")
    }
    
    func testDidTap_successWithNotAnnotationSelection() {
//        let vehicle = VehicleData(name: "vehicleName", address: "vehicleAddress", coordinates: [1.0, 1.0, 1.0], engineType: EngineType.ce, fuel: 10, exterior: VehiclePartStatus.good, interior: VehiclePartStatus.good, vin: "vehicleVin")
//
//        let vehicleMarkerView = VehicleMarkerView(annotation: VehicleAnnotation(vehicleData: vehicle), reuseIdentifier: VehicleMarkerView.identifier)
//        vehicleMarkerView.isSelected = false
        
        let gesture = UITapGestureRecognizer()
        
        UIView().addGestureRecognizer(gesture)
        
        viewModel.didTap(gesture: gesture)
        
        assert(view.deselectAndShowVehicleAnnotationsCallCount == 1, "view.deselectAndShowVehicleAnnotations should be called 1 time.")
        assert(view.hideVehicleAnnotationsCallCount == 0, "hideVehicleAnnotations should not be called.")
    }

}
