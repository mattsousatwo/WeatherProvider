//
//  EnableLocationView.swift
//  Weather Provider
//
//  Created by Matthew Sousa on 5/22/23.
//

import SwiftUI
import CoreLocationUI

struct EnableLocationView: View {
    @StateObject var locationManager = LocationManager()
    var body: some View {
        
        Background {
            VStack {
                switch locationManager.locationManager.authorizationStatus {
                    case .authorizedWhenInUse:
                        WPText("Your current location is: ")
                        WPText("latitude: \(locationManager.locationManager.location?.coordinate.latitude.description ?? "Error Loading")")
                        WPText("longitude: \(locationManager.locationManager.location?.coordinate.longitude.description ?? "Error Loading")")
                    case .restricted, .denied:
                        WPText("Current location data was restricted or denied.")
                    case .notDetermined:
                        WPText("Gathering location data...")
                        ProgressView()
                            .padding()
                    default:
                        ProgressView() 
                }
                
            }
        }
    }
}

struct EnableLocationView_Previews: PreviewProvider {
    static var previews: some View {
        EnableLocationView()
    }
}
