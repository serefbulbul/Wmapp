//
//  VehicleMarkerView.swift
//  Wmapp
//
//  Created by Seref Bulbul on 12.02.2019.
//  Copyright © 2019 Seref Bulbul. All rights reserved.
//

import UIKit
import MapKit

class VehicleMarkerView: MKAnnotationView {

    static let identifier = "VehicleMarkerView"
    
    override var annotation: MKAnnotation? {
        willSet {
            canShowCallout = true

            image = UIImage(named: "taxi")
        }
    }

}
