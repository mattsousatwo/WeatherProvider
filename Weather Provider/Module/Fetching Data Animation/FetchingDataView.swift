//
//  FetchingDataView.swift
//  Weather Provider
//
//  Created by Matthew Sousa on 5/26/23.
//

import SwiftUI

/// View to display a loading animation between the Home and Onboarding Views 
@available(iOS 17.0, *)
struct FetchingDataView: View {
    @EnvironmentObject var userDelegate: UserDelegate
    
    @ObservedObject var weatherNetwork = WeatherNetwork()
    @StateObject var locationManager = LocationManager()
    
    @State private var weatherInfo: WeatherInfo? = nil
    
    var body: some View {
        Background(userDelegate.theme) {
            VStack {
                Spacer()
                if let weatherInfo = weatherInfo {
                    WPNavigationLink(label: "Go to Home", theme: userDelegate.theme) {
                        HomeView(weatherInfo: weatherInfo)
                            .environmentObject(userDelegate)
                    }
                }
                Spacer()
            }
        }
        .onAppear {
            print("EnableLocation - Theme - \(userDelegate.theme)")
            Task(priority: .background) {
                print("FetchingDataView")
                weatherInfo = try await weatherNetwork.fetchTenDayForecast(in: locationManager.locationManager.longituteAndLatitude)
            }
        }
        
    }
}

@available(iOS 17.0, *)
struct FetchingDataView_Previews: PreviewProvider {
    static var previews: some View {
        FetchingDataView()
    }
}
