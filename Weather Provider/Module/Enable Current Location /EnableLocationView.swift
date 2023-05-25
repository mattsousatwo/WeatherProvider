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
    @ObservedObject var weatherNetwork = WeatherNetwork()
//    @StateObject var s: LocationManager? = nil
    
    @State private var fetchTenDayForecast: Bool = false
    @State private var dataLoaded: Bool = false
    @State private var longitudeAndLatitude: String = ""
    
    @State private var weatherInfo: WeatherInfo? = nil
    
    var body: some View {
        
        Background {
            VStack {
                WPOTitle("Enable Location Services")
                Spacer()
                switch locationManager.locationManager.authorizationStatus {
                    case .authorizedWhenInUse, .authorizedAlways:
                        if let weather = weatherInfo {
                            weatherDisplay(location: weather.location.name,
                                           time: weather.location.localtime,
                                           temp: weather.currentWeather.temperatureFahrenheit,
                                           feelsLike: weather.currentWeather.feelsLikeFahrenheit,
                                           condition: weather.currentWeather.condition)
                            Spacer()
                            WPNavigationLink(label: "Get Started!") {
                                Background {
                                    WPText("Get Started")
                                }
                            }
                            Spacer()
                        } else {
                            VStack {
                                WPText("Gathering location data...")
                                Spacer()
                            }
                            .onAppear {
                                let longAndLat = "\(locationManager.locationManager.location?.coordinate.latitude.description ?? "Error Loading"),\(locationManager.locationManager.location?.coordinate.longitude.description ?? "Error Loading")"
                                Task {
                                    weatherInfo = try await weatherNetwork.fetchTenDayForecast(in: longAndLat)
                                }
                            }
                        }
                        
                        
                    case .restricted, .denied:
                        WPText("Current location data was restricted or denied.")
                        Spacer()
                        WPButton("Request Access", action: {
//                            locationManager.requestLocationAccess()
                            locationManager.locationManager.requestWhenInUseAuthorization()
                            locationManager.locationManager.startUpdatingLocation()
                            
// 
                        })
                        .cornerRadius(12)
                        .foregroundColor(Color("TextColor"))
                        .tint(Color("WeatherBackground"))
                        Spacer()
                    case .notDetermined:
                        WPText("Gathering location data...")
                        ProgressView()
                            .padding()
                        Spacer()
                    default:
                        ProgressView()
                        Spacer()
                }
            }
        }
        
    }
    
    func weatherDisplay(location: String, time: String, temp: Double, feelsLike: Double, condition: WeatherCondition) -> some View {
        return VStack {
            WPOTitle(location)
            Text(time)
                .fontDesign(.rounded)
            //                .foregroundColor(theme.textColor)
            WPText("\(condition.text)")
                .padding(.bottom, 2)
            
            Image(systemName: "sun.max.fill")
                .resizable()
                .frame(width: 25, height: 25)
                .foregroundColor(.yellow)
                .padding(.vertical, 5)
            
            Text("\(temp)" + "°")
                .fontDesign(.rounded)
            //                .foregroundColor(theme.textColor)
                .padding(.vertical, 2)
            
            WPText("Feels like: \(temp)" + "°")
        }
        .padding()
        .background(Color("WeatherBackground"))
        .cornerRadius(12)
        
    }

}

struct EnableLocationView_Previews: PreviewProvider {
    static var previews: some View {
        Background {
//            EnableLocationView().weatherDisplay(location: "Cambridge",
//                                                time: "12PM",
//                                                temp: 55.0,
//                                                feelsLike: 52.0,
//                                                condition: WeatherCondition(text: "Sunny", icon: "Icon", code: 12))
            
            LocationButton(.shareCurrentLocation) {
//                locationManager.requestLocation()
            }
            
            .cornerRadius(12)
            .labelStyle(.titleOnly)
            .foregroundColor(Color("TextColor"))
            .tint(Color("WeatherBackground"))
            
        }
        .colorScheme(.dark)
    }
}
