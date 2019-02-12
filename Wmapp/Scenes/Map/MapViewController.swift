//
//  MapViewController.swift
//  Wmapp
//
//  Created by Seref Bulbul on 6.02.2019.
//  Copyright © 2019 Seref Bulbul. All rights reserved.
//

import UIKit
import MapKit

protocol MapViewProtocol: AnyObject {

    /**
     Put given location with latitude and longitude to center of the map using defined regionRadius
     */
    func centerMapOnLocation(latitude: Double, longitude: Double)

    /**
     Deselect all annotations, get vehicle annotations from view model and show in the map view
     */
    func deselectAndShowVehicleAnnotations()

    /**
     Hide all vehicle annotations in the map view except given annotation
     */
    func hideVehicleAnnotations(exceptAnnotation: VehicleAnnotation)

    /**
     Show alert message with a given message string
     */
    func showAlert(message: String?)

}

private enum Constants {

    static let regionRadius: CLLocationDistance = 1000

}

@objcMembers class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!

    var vehicles: [VehicleData]?
    var selectedVehicleIndex: Int?
    private var viewModel: MapViewModelProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()

        PermissionManager.instance.checkPermission()

        if let vehicles = vehicles {
            viewModel = MapViewModel(view: self, vehicles: vehicles, selectedVehicleIndex: selectedVehicleIndex)

            viewModel?.initialSetup()
        } else {
            showAlert(message: "Oops, an unknown error occured.")
        }

        let tap = UITapGestureRecognizer(target: viewModel, action: #selector(MapViewModel.didTap(gesture:)))
        mapView.addGestureRecognizer(tap)
    }

}

extension MapViewController: MapViewProtocol {

    func centerMapOnLocation(latitude: Double, longitude: Double) {
        let coordinateRegion = MKCoordinateRegion(center: CLLocation(latitude: latitude, longitude: longitude).coordinate, latitudinalMeters: Constants.regionRadius, longitudinalMeters: Constants.regionRadius)

        mapView.setRegion(coordinateRegion, animated: true)
    }

    func updateAnnotations(vehicleAnnotations: [VehicleAnnotation]) {
        var annotations = vehicleAnnotations

        annotations.removeAll { (vehicleAnnotation) -> Bool in
            viewModel?.visibleVehicleAnnotations.contains(where: { (annotation) -> Bool in
                annotation.coordinate.latitude == vehicleAnnotation.coordinate.latitude &&
                    annotation.coordinate.longitude == vehicleAnnotation.coordinate.longitude
            }) ?? false
        }

        DispatchQueue.main.async {
            self.mapView.addAnnotations(vehicleAnnotations)
        }
    }

    func deselectAndShowVehicleAnnotations() {
        for annotation in mapView.annotations {
            mapView.view(for: annotation)?.isSelected = false
        }

        var vehicleAnnotations = viewModel?.vehicles.map({ (vehicleData) -> VehicleAnnotation in
            VehicleAnnotation(vehicleData: vehicleData)
        })

        vehicleAnnotations?.removeAll(where: { (vehicleAnnotation) -> Bool in
            mapView.annotations.contains(where: { (annotation) -> Bool in
                annotation.coordinate.latitude == vehicleAnnotation.coordinate.latitude &&
                    annotation.coordinate.longitude == vehicleAnnotation.coordinate.longitude
            })
        })

        if let vehicleAnnotations = vehicleAnnotations {
            DispatchQueue.main.async {
                self.mapView.addAnnotations(vehicleAnnotations)
            }
        }
    }

    func hideVehicleAnnotations(exceptAnnotation: VehicleAnnotation) {
        mapView.removeAnnotations(mapView.annotations.filter({ (annotation) -> Bool in
            !(annotation.coordinate.latitude == exceptAnnotation.coordinate.latitude &&
                    annotation.coordinate.longitude == exceptAnnotation.coordinate.longitude)
        }))
    }

    func showAlert(message: String?) {
        var alertMessage = message

        if message == nil {
            alertMessage = "Oops, an unknown error occured."
        }

        let alertController = UIAlertController(title: "Alert", message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel))

        self.present(alertController, animated: true, completion: nil)
    }

}

extension MapViewController: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? VehicleAnnotation else { return nil }

        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: VehicleMarkerView.identifier)

        if annotationView == nil {
            annotationView = VehicleMarkerView(annotation: annotation, reuseIdentifier: VehicleMarkerView.identifier)
        } else {
            annotationView?.annotation = annotation
        }

        annotationView?.isEnabled = false

        return annotationView
    }

}
