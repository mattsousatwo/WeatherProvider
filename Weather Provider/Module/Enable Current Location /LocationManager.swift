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
    
    func requestLocationAccess() {
        locationManager.requestWhenInUseAuthorization()
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
                manager.requestWhenInUseAuthorization()
                break
            case .notDetermined:
                authorizationStatus = .notDetermined
                manager.requestWhenInUseAuthorization()
                break
            case .authorizedAlways:
                authorizationStatus = .authorizedAlways
                locationManager.requestLocation()
            default:
                break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error: \(error.localizedDescription)")
    }

}



extension CLLocationManager {
    /// Returns a string with the users longitude and latitude
    var longituteAndLatitude: String {
        let lat = "\(location?.coordinate.latitude.description ?? "Error Loading")"
        let long = "\(location?.coordinate.longitude.description ?? "Error Loading")"
        return lat + "," + long
    }
}
