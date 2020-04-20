//
//  LocationManager.swift
//  AppleWeatherApp
//
//  Created by Natalia on 15.04.2020.
//  Copyright © 2020 Natalia. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

protocol OurLocationManagerDelegate: AnyObject {
    func locationUpdated(lat: Double, lon: Double)
}

class LocationManager: NSObject, CLLocationManagerDelegate {
    var locationManager: CLLocationManager?
    weak var delegate: OurLocationManagerDelegate?
    
    private var lastLocation = CLLocationCoordinate2D(latitude: 55.75, longitude: 37.61)
    
    init(location: CLLocationManager, delegate: OurLocationManagerDelegate) {
        super.init()
        
        self.locationManager = location
        self.delegate = delegate
        locationManager?.delegate = self
        
        delegate.locationUpdated(lat: 55.75, lon: 37.61)
    }
    
    func getPermission() {
        locationManager?.requestWhenInUseAuthorization()
        
        if (CLLocationManager.authorizationStatus() == .authorizedWhenInUse || CLLocationManager.authorizationStatus() == .authorizedAlways) {
            locationManager?.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if (status == .authorizedWhenInUse || status == .authorizedAlways) {
            manager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let locationValue = manager.location?.coordinate {
            let lat = locationValue.latitude
            let lon = locationValue.longitude
            
            lastLocation = locationValue
            delegate?.locationUpdated(lat: lat, lon: lon)
        }
    }
    
    func getLastLocation() -> (Double, Double) {
        return (lastLocation.latitude, lastLocation.longitude)
    }
}
