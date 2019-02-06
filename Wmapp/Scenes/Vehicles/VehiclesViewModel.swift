//
//  VehiclesViewModel.swift
//  Wmapp
//
//  Created by Seref Bulbul on 6.02.2019.
//  Copyright © 2019 Seref Bulbul. All rights reserved.
//

import Foundation

protocol VehiclesViewModelProtocol {
    
}

class VehiclesViewModel {
    
    private weak var view: VehiclesViewProtocol!
    private var networkService: NetworkServiceProtocol!
    
    private init() { }
    
    init(view: VehiclesViewProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
    }
    
}

extension VehiclesViewModel: VehiclesViewModelProtocol {
    
}
