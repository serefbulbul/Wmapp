//
//  VehicleAnnotation.swift
//  Wmapp
//
//  Created by Seref Bulbul on 10.02.2019.
//  Copyright © 2019 Seref Bulbul. All rights reserved.
//

import Foundation
import MapKit

class VehicleAnnotation: NSObject, MKAnnotation {

    let vehicleData: VehicleData
    let coordinate: CLLocationCoordinate2D
    let title: String?
    let subtitle: String?

    init(vehicleData: VehicleData) {
        self.vehicleData = vehicleData
        self.title = "123"//String(vehicleData.name)
        self.subtitle = vehicleData.address
        self.coordinate = CLLocationCoordinate2D(latitude: vehicleData.coordinates[1], longitude: vehicleData.coordinates[0])

        super.init()
    }
    
}
