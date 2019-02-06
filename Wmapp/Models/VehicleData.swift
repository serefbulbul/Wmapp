//
//  VehicleData.swift
//  Wmapp
//
//  Created by Seref Bulbul on 6.02.2019.
//  Copyright © 2019 Seref Bulbul. All rights reserved.
//

import Foundation

class VehicleData: Codable {

    let address: String
    let coordinates: [Double]
    let engineType: String
    let exterior: String
    let fuel: Int
    let interior: String
    let name: String
    let vin: String

    enum CodingKeys: String, CodingKey {

        case address
        case coordinates
        case engineType
        case exterior
        case fuel
        case interior
        case name
        case vin

    }

}
