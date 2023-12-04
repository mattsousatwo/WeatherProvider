//
//  FetchingDataView.swift
//  Weather Provider
//
//  Created by Matthew Sousa on 5/26/23.
//

import SwiftUI

/// View to display a loading animation between the Home and Onboarding Views 
struct FetchingDataView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @ObservedObject var weatherNetwork = WeatherNetwork()
    @StateObject var locationManager = LocationManager()
    
    @State private var weatherInfo: WeatherInfo? = nil
    
    var body: some View {
        Background(themeManager.currentTheme) {
            VStack {
                Spacer()
                if let weatherInfo = weatherInfo {
                    WPNavigationLink(label: "Go to Home", theme: themeManager.currentTheme) {
                        HomeView(weatherInfo: weatherInfo)
                            .environmentObject(themeManager)
                    }
                }
                Spacer()
            }
        }
        .onAppear {
            let longAndLat = "\(locationManager.locationManager.location?.coordinate.latitude.description ?? "Error Loading"),\(locationManager.locationManager.location?.coordinate.longitude.description ?? "Error Loading")"
            print("EnableLocation - Theme - \(themeManager.currentTheme)")
            Task {
                weatherInfo = try await weatherNetwork.fetchTenDayForecast(in: longAndLat)
            }
        }
        
    }
}

struct FetchingDataView_Previews: PreviewProvider {
    static var previews: some View {
        FetchingDataView()
    }
}
