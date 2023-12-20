//
//  EnableLocationView.swift
//  Weather Provider
//
//  Created by Matthew Sousa on 5/22/23.
//

import SwiftUI
import CoreLocationUI

/// Durring the onboarding process this view is shown to allow the user to easily enable the app to access the users current location
@available(iOS 17.0, *)
struct EnableLocationView: View {
    @EnvironmentObject var userDelegate: UserDelegate
    
    @StateObject var locationManager = LocationManager()
    @ObservedObject var weatherNetwork = WeatherNetwork()
    
    @State private var weatherInfo: WeatherInfo? = nil
    @State private var goToSettingsAlert: Bool = false
    
    var body: some View {
        
        Background(userDelegate.theme) {
            VStack {
                WPOTitle("Enable Location Services", color: userDelegate.theme.textColor)
                Spacer()
                switch locationManager.locationManager.authorizationStatus {
                    case .authorizedWhenInUse, .authorizedAlways:
                        if let weather = weatherInfo {
                            TemporaryWeatherDisplay(weather: weather,
                                                    theme: userDelegate.theme)
                            Spacer()
                            WPNavigationLink(label: "Get Started!", theme: userDelegate.theme) {
                                HomeView(weatherData: [weather])
                                        .environmentObject(userDelegate)
                            }
                            Spacer()
                        } else {
                            VStack {
                                WPText("Gathering location data...", color: userDelegate.theme.textColor)
                                Spacer()
                            }
                            .onAppear {
                                print("EnableLocation - Theme - \(userDelegate.theme)")
                                Task {
                                    print("EnableLocationView")
                                    weatherInfo = try await weatherNetwork.fetchTenDayForecast(in: locationManager.locationManager.longituteAndLatitude)
                                }
                            }
                        }
                        
                        
                    case .restricted, .denied:
                        WPText("Current location data was restricted or denied.", color: userDelegate.theme.textColor)
                        Spacer()
                        WPButton("Request Access",
                                 accent: userDelegate.theme.weatherBackground,
                                 textColor: userDelegate.theme.textColor, action: {
                            goToSettingsAlert = true
                        })
                        .cornerRadius(12)
                        Spacer()
                    case .notDetermined:
                        WPText("Gathering location data...", color: userDelegate.theme.textColor)
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
        .navigationBarBackButtonHidden(true)
        
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
