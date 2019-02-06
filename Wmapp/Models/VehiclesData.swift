//
//  VehiclesData.swift
//  Wmapp
//
//  Created by Seref Bulbul on 6.02.2019.
//  Copyright © 2019 Seref Bulbul. All rights reserved.
//

import Foundation

class VehiclesData: Codable {

    public var vehicles: [VehicleData]

    init(vehicles: [VehicleData]) {
        self.vehicles = vehicles
    }

    private enum CodingKeys: String, CodingKey {
        case vehicles = "placemarks"
    }

}
