//
//  PermissionManager.swift
//  Wmapp
//
//  Created by Seref Bulbul on 6.02.2019.
//  Copyright © 2019 Seref Bulbul. All rights reserved.
//

import Foundation
import CoreLocation

protocol PermissionManagerProtocol {
    
    static var instance: PermissionManagerProtocol { get }
    
    func checkPermission()
}

final class PermissionManager: NSObject, PermissionManagerProtocol {
    
    static var instance: PermissionManagerProtocol = PermissionManager()
    
    private let locationManager = CLLocationManager()
    
    private override init() {
        super.init()
        
        locationManager.delegate = self
    }
    
    func checkPermission() {
        switch CLLocationManager.authorizationStatus() {
        case .denied, .restricted:
            return
        case .authorizedAlways, .authorizedWhenInUse:
            return
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
}

extension PermissionManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
    }
    
}
