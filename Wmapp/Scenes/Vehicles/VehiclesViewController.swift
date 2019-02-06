//
//  VehiclesViewController.swift
//  Wmapp
//
//  Created by Seref Bulbul on 6.02.2019.
//  Copyright © 2019 Seref Bulbul. All rights reserved.
//

import UIKit

protocol VehiclesViewProtocol: AnyObject {
    
}

class VehiclesViewController: UIViewController {

    private var viewModel: VehiclesViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

extension VehiclesViewController: MapViewProtocol {
    
}
