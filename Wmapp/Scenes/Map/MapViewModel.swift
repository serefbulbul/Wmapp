//
//  MapViewModel.swift
//  Wmapp
//
//  Created by Seref Bulbul on 6.02.2019.
//  Copyright © 2019 Seref Bulbul. All rights reserved.
//

import UIKit

protocol MapViewModelProtocol {

    var vehicles: [VehicleData] { get }
    var vehicleAnnotations: [VehicleAnnotation] { get }
    var visibleVehicleAnnotations: [VehicleAnnotation] { get }

    /**
     Make initial UI setup according to selectedVehicleData
     */
    func initialSetup()

    /**
     Arrange visibilities of the annotations
     */
    func didTap(gesture: UITapGestureRecognizer)

}

class MapViewModel {

    var vehicles = [VehicleData]()

    var vehicleAnnotations = [VehicleAnnotation]()
    var visibleVehicleAnnotations = [VehicleAnnotation]()

    private var selectedVehicleIndex: Int?
    private weak var view: MapViewProtocol!

    private init() { }

    init(view: MapViewProtocol, vehicles: [VehicleData], selectedVehicleIndex: Int?) {
        self.view = view
        self.vehicles = vehicles
        self.selectedVehicleIndex = selectedVehicleIndex
        
        vehicleAnnotations = vehicles.map({ (vehicleData) -> VehicleAnnotation in
            VehicleAnnotation(vehicleData: vehicleData)
        })
    }

}

extension MapViewModel: MapViewModelProtocol {

    func initialSetup() {
        if let selectedVehicleIndex = selectedVehicleIndex, vehicles.count > selectedVehicleIndex {
            view.centerMapOnLocation(latitude: vehicles[selectedVehicleIndex].coordinates[1], longitude: vehicles[selectedVehicleIndex].coordinates[0])
        }

        view.deselectAndShowVehicleAnnotations()
    }

    @objc func didTap(gesture: UITapGestureRecognizer) {
        if let view = gesture.view?.hitTest(gesture.location(in: gesture.view), with: nil) as? VehicleMarkerView,
            let annotation = view.annotation as? VehicleAnnotation {
            if view.isSelected {
                self.view.deselectAndShowVehicleAnnotations()
            } else {
                view.isSelected = true
                self.view.hideVehicleAnnotations(exceptAnnotation: annotation)
            }
        } else {
            view.deselectAndShowVehicleAnnotations()
        }
    }

}
