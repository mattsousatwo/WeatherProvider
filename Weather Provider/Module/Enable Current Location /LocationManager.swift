//
//  LocationManager.swift
//  Weather Provider
//
//  Created by Matthew Sousa on 5/22/23.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    var locationManager = CLLocationManager()
    @Published var location: CLLocationCoordinate2D?
    @Published var authorizationStatus: CLAuthorizationStatus?
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func requestLocation() {
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first?.coordinate
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
            case .authorizedWhenInUse:
                authorizationStatus = .authorizedWhenInUse
                locationManager.requestLocation()
                break
            case .restricted:
                authorizationStatus = .restricted
                break
            case .denied:
                authorizationStatus = .denied
                break
            case .notDetermined:
                authorizationStatus = .notDetermined
                manager.requestWhenInUseAuthorization()
                break
            default:
                break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error: \(error.localizedDescription)")
    }
}
