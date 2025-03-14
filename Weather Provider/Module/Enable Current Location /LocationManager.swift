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
    let geocoder = CLGeocoder()
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
    
    
    /// Fetch Location from Latitude/Longitude coordinates 
    func getLocationFrom(lat: String, long: String) -> Location? {
        let location = CLLocation(latitude: Double(lat)!, longitude: Double(long)!)
        
        // Create an object outside of the reverse geo search closure to capture the Location
        
        var name: String = ""
        var region: String  = ""
        var country: String  = ""
        
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            guard let error = error else {
                print("Error: \(error?.localizedDescription ?? "Nil")")
                return
            }
            guard let placemarks = placemarks, let placemark = placemarks.first else {
                print("No Placemarks Found")
                return
            }
            if let placeName = placemark.name,
               let placeRegion = placemark.region?.identifier,
               let placeCountry = placemark.country {
                name = placeName
                region = placeRegion
                country = placeCountry
            }
        }
        return Location(name: name,
                        region: region,
                        country: country,
                        latitude: Double(lat)!,
                        longitude: Double(long)!)
        
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
