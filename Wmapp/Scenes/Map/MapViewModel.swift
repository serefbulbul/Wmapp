//
//  MapViewModel.swift
//  Wmapp
//
//  Created by Seref Bulbul on 6.02.2019.
//  Copyright © 2019 Seref Bulbul. All rights reserved.
//

import Foundation

protocol MapViewModelProtocol {
    
}

class MapViewModel {
    
    private weak var view: MapViewProtocol!
    private var networkService: NetworkServiceProtocol!
    
    private init() { }
    
    init(view: MapViewProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
    }
    
}

extension MapViewModel: MapViewModelProtocol {
    
}
