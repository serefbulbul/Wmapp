//
//  VehiclesViewModel.swift
//  Wmapp
//
//  Created by Seref Bulbul on 6.02.2019.
//  Copyright © 2019 Seref Bulbul. All rights reserved.
//

import Foundation

protocol VehiclesViewModelProtocol {

    var vehicles: [VehicleData] { get }

    /**
     Make a get request for VehiclesData
     */
    func requestVehicles()
    
}

class VehiclesViewModel {

    private weak var view: VehiclesViewProtocol!
    private var networkService: NetworkServiceProtocol!

    internal var vehicles = [VehicleData]()

    private init() { }

    init(view: VehiclesViewProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
    }

}

extension VehiclesViewModel: VehiclesViewModelProtocol {

    func requestVehicles() {
        networkService.getVehicles(success: { [weak self] (vehiclesData) in
            guard let strongSelf = self else { return }
            
            strongSelf.vehicles = vehiclesData.vehicles
            
            strongSelf.view.updateVehicles()
        }) { [weak self] (error) in
            guard let strongSelf = self else { return }
            
            strongSelf.view.showAlert(message: error.errorMessage)
        }
    }

}
