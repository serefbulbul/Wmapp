//
//  VehiclesTableViewCell.swift
//  Wmapp
//
//  Created by Seref Bulbul on 6.02.2019.
//  Copyright © 2019 Seref Bulbul. All rights reserved.
//

import UIKit

class VehiclesTableViewCell: UITableViewCell {

    static let identifier = "VehiclesTableViewCell"

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var fuelLabel: UILabel!

    func setWithModel(vehicleData: VehicleData) {
        self.nameLabel.text = vehicleData.name
        self.addressLabel.text = vehicleData.address
        self.fuelLabel.text = String(vehicleData.fuel)
    }

}
