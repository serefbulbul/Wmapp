//
//  VehicleData.swift
//  Wmapp
//
//  Created by Seref Bulbul on 6.02.2019.
//  Copyright © 2019 Seref Bulbul. All rights reserved.
//

import Foundation

class VehicleData: Codable {

    let name: String
    let address: String
    let coordinates: [Double]
    let engineType: String
    let fuel: Int
    let exterior: String
    let interior: String
    let vin: String
    
    init(name: String, address: String, coordinates: [Double], engineType: String, fuel: Int, exterior: String, interior: String, vin: String) {
        self.name = name
        self.address = address
        self.coordinates = coordinates
        self.engineType = engineType
        self.fuel = fuel
        self.exterior = exterior
        self.interior = interior
        self.vin = vin
    }

    enum CodingKeys: String, CodingKey {

        case name
        case address
        case coordinates
        case engineType
        case fuel
        case exterior
        case interior
        case vin

    }

}
