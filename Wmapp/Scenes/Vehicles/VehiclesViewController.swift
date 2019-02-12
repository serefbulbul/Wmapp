//
//  VehiclesViewController.swift
//  Wmapp
//
//  Created by Seref Bulbul on 6.02.2019.
//  Copyright © 2019 Seref Bulbul. All rights reserved.
//

import UIKit

protocol VehiclesViewProtocol: AnyObject {

    /**
     Get vehicles from view model and reload table view
     */
    func updateVehicles()

    /**
     Show alert message with a given message string
     */
    func showAlert(message: String?)

}

class VehiclesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    private var viewModel: VehiclesViewModelProtocol?
    private let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = VehiclesViewModel(view: self, networkService: NetworkService.instance)

        refreshControl.addTarget(self, action: #selector(refreshTableView), for: UIControl.Event.valueChanged)
        tableView.refreshControl = refreshControl
        
        self.viewModel?.requestVehicles()
    }

    @objc func refreshTableView() {
        self.viewModel?.requestVehicles()
    }

}

extension VehiclesViewController: VehiclesViewProtocol {

    func updateVehicles() {
        DispatchQueue.main.async {
            if let refreshControl = self.tableView.refreshControl, refreshControl.isRefreshing {
                refreshControl.endRefreshing()
            }

            self.tableView.reloadData()
        }
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

extension VehiclesViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.vehicles.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: VehiclesTableViewCell.identifier) as! VehiclesTableViewCell

        if let vehicle = viewModel?.vehicles[indexPath.row] {
            cell.setWithModel(vehicleData: vehicle)
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard.init(name: "Map", bundle: nil)
        let mapViewController = storyboard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController

        mapViewController.vehicles = viewModel?.vehicles
        mapViewController.selectedVehicleIndex = indexPath.row
        
        navigationController?.pushViewController(mapViewController, animated: true)
    }

}
