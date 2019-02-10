//
//  MapViewController.swift
//  Wmapp
//
//  Created by Seref Bulbul on 6.02.2019.
//  Copyright © 2019 Seref Bulbul. All rights reserved.
//

import UIKit

protocol MapViewProtocol: AnyObject {

}

class MapViewController: UIViewController {

    public var vehicles: [VehicleData]?

    private var viewModel: MapViewModelProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

extension MapViewController: MapViewProtocol {

}
