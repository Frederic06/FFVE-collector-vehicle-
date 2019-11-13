//
//  ClubResearchViewController.swift
//  FFVE
//
//  Created by Margarita Blanc on 31/10/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

final class MemberSearchViewController: UIViewController {
     // MARK: - Outlets
    
    @IBOutlet weak var descriptionTitle: UILabel!
    
    @IBOutlet weak var criteriaTitle: UILabel!
    
    @IBOutlet weak var departmentTitle: UILabel!
    
    @IBOutlet weak var specialityTitle: UILabel!
    
    @IBOutlet weak var specialityPicker: UIPickerView!
    
    @IBOutlet weak var departmentPicker: UIPickerView!
    //
    @IBOutlet weak var mapResult: MKMapView!

    @IBOutlet weak var tableResult: UITableView!
    
    @IBOutlet weak var `switch`: UISwitch!
    //
    @IBOutlet weak var switchTitle: UILabel!

    // MARK: - Properties

    var viewModel: MemberResearchViewModel!
    
    let locationManager = CLLocationManager()

       // MARK: - View life cycle
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
              mapResult.delegate = self

                 bind(to: viewModel)
                 viewModel.viewDidAppear()
    }


//        MARK: - Private methods

       private func bind(to viewModel: MemberResearchViewModel) {
        viewModel.switchTitle = { [weak self] text in
            self?.switchTitle.text = text
        }
        viewModel.departmentPickerTitle = { [weak self] text in
            self?.departmentTitle.text = text
        }
        viewModel.specialityPickerIsOn = { [weak self] status in
            if status == true { self?.specialityPicker.isHidden = false
            } else {
                self?.specialityPicker.isHidden = true
            }
        }
        viewModel.specialityTitle = { [weak self] text in
            self?.specialityTitle.text = text
        }
        
        viewModel.criteriaTitle = { [weak self] text in
            self?.criteriaTitle.text = text
            
        }
       }
    
    private func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
        }
        else {
            
        }
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    private func centerViewOnUserLocation(){
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: 1000, longitudinalMeters: 1000)
            mapResult.setRegion(region, animated: true)
        }
    }
    
    private func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            mapResult.showsUserLocation = true
            centerViewOnUserLocation()
            locationManager.startUpdatingLocation()
        case .denied :
            break
        case .notDetermined:
            break
        case .restricted:
            break
        case .authorizedAlways:
            break
        @unknown default:
            break
        }
    }

       // MARK: - Actions

    @IBAction func `switch`(_ sender: UISwitch) {
        if self.switch.isOn {
            mapResult.isHidden = false
            tableResult.isHidden = true
        }
        else {
            mapResult.isHidden = true
            tableResult.isHidden = false
        }
    }
}

extension MemberSearchViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Well be back
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        //Well be back
    }
}

extension MemberSearchViewController: MKMapViewDelegate {
    
}
