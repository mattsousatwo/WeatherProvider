//
//  EnableLocationView.swift
//  Weather Provider
//
//  Created by Matthew Sousa on 5/22/23.
//

import SwiftUI
import CoreLocationUI

/// Durring the onboarding process this view is shown to allow the user to easily enable the app to access the users current location
struct EnableLocationView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @StateObject var locationManager = LocationManager() 
    @ObservedObject var weatherNetwork = WeatherNetwork()
    
    @State private var fetchTenDayForecast: Bool = false
    @State private var dataLoaded: Bool = false
    @State private var longitudeAndLatitude: String = ""
    
    @State private var weatherInfo: WeatherInfo? = nil
    @State private var goToSettingsAlert: Bool = false
    
    var body: some View {
        
        Background(themeManager.currentTheme) {
            VStack {
                WPOTitle("Enable Location Services", color: themeManager.currentTheme.textColor)
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
                            WPNavigationLink(label: "Get Started!", theme: themeManager.currentTheme) {
                                Background(themeManager.currentTheme) {
                                    FetchingDataView()
                                        .environmentObject(themeManager)
                                }
                            }
                            Spacer()
                        } else {
                            VStack {
                                WPText("Gathering location data...", color: themeManager.currentTheme.textColor)
                                Spacer()
                            }
                            .onAppear {
                                let longAndLat = "\(locationManager.locationManager.location?.coordinate.latitude.description ?? "Error Loading"),\(locationManager.locationManager.location?.coordinate.longitude.description ?? "Error Loading")"
                                print("EnableLocation - Theme - \(themeManager.currentTheme)")
                                Task {
                                    weatherInfo = try await weatherNetwork.fetchTenDayForecast(in: longAndLat)
                                }
                            }
                        }
                        
                        
                    case .restricted, .denied:
                        WPText("Current location data was restricted or denied.", color: themeManager.currentTheme.textColor)
                        Spacer()
                        WPButton("Request Access", accent: themeManager.currentTheme.weatherBackground, textColor: themeManager.currentTheme.textColor, action: {
                            goToSettingsAlert = true
                        })
                        .cornerRadius(12)
//                        .foregroundColor(Color("TextColor"))
//                        .tint(Color("WeatherBackground"))
                        Spacer()
                    case .notDetermined:
                        WPText("Gathering location data...", color: themeManager.currentTheme.textColor)
                        ProgressView()
                            .padding()
                        Spacer()
                    default:
                        ProgressView()
                        Spacer()
                }
            }
            .alert(isPresented: $goToSettingsAlert) {
                Alert (title: Text("Current Location Weather"),
                       message: Text("Weather Provider can not access weather in current location. Go to Settings to enable location services to allow Weather Provider to get the weather based on your location."),
                       primaryButton: .default(Text("Go to Settings"), action: {
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                }),
                       secondaryButton: .default(Text("Cancel"), action: {
                    goToSettingsAlert = false
                }))
            }
        }
        
    }
    
    func weatherDisplay(location: String, time: String, temp: Double, feelsLike: Double, condition: WeatherCondition) -> some View {
        return VStack {
            WPOTitle(location, color: themeManager.currentTheme.textColor)
            Text(time)
                .fontDesign(.rounded)
            //                .foregroundColor(theme.textColor)
            WPText("\(condition.text)", color: themeManager.currentTheme.textColor)
                .padding(.bottom, 2)
            
            Image(systemName: "sun.max.fill")
                .resizable()
                .frame(width: 25, height: 25)
                .foregroundColor(.yellow)
                .padding(.vertical, 5)
            
            Text("\(temp)" + "°")
                .fontDesign(.rounded)
                .foregroundColor(themeManager.currentTheme.textColor)
                .padding(.vertical, 2)
            
            WPText("Feels like: \(temp)" + "°", color: themeManager.currentTheme.textColor)
        }
        .padding()
        .background(themeManager.currentTheme.weatherBackground)
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
//            .foregroundColor(Color("TextColor"))
//            .foregroundColor(.red)
            .tint(Color("WeatherBackground"))
            
        }
        .colorScheme(.dark)
    }
}
