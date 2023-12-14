//
//  HomeView.swift
//  Weather Provider
//
//  Created by Matthew Sousa on 5/17/23.
//

import SwiftUI
import CoreLocation

/// Home view is used to display all the main weather information
@available(iOS 17.0, *)
struct HomeView: View {
    
    @EnvironmentObject var themeManager: ThemeManager
    @EnvironmentObject var userDelegate: UserDelegate
    
    @StateObject var locationManager = LocationManager()
    var weatherInfo: WeatherInfo

    @State var viewState: ViewState = .loading
    
    
    /// View Model for the Home Module
    let viewModel = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            Background(themeManager.currentTheme) {
                VStack {
                    switch viewState {
                        case .loading:
                            ProgressView()
                        case .failure(let reason):
                            Text("Failure - \(reason)")
                        case .success:
                            viewStructure()
                    }
                    
                    
                    
                    HStack {
                        Spacer()
                        WPNavigationLink(label: "Settings") {
                            SettingsView()
                                .environmentObject(themeManager)
                                .environmentObject(userDelegate)
                        }
                        
                        
                    }
                    
                }
                
                
                
                
                
                
                
            }
        }
        .tint(themeManager.currentTheme.accentColor)
        .onAppear {
            print("Home - Loading")
            switch locationManager.locationManager.authorizationStatus {
                case .denied, .restricted, .notDetermined:
                    viewState = .failure(reason: "Authorization Status - \(locationManager.locationManager.authorizationStatus.name)")
                    locationManager.locationManager.requestWhenInUseAuthorization()
                    print("Home - Failure - \(viewState)")
                case .authorized, .authorizedAlways, .authorizedWhenInUse:
                    viewState = .success
                    print("Home - Success - \(viewState)")
                default:
                    viewState = .failure(reason: "Unknown Reason")
                    print("Home - Default Failure - \(viewState)")
            }
        }
        
        
        
        
    }

}


@available(iOS 17.0, *)
extension HomeView {
    
    func viewStructure() -> some View {
        
            ScrollView(.vertical) {
                VStack {
                    mainWeatherDisplay()
                    hourlyWeatherHStack()
                    tenDayForecast()
                    Spacer()
                }
            }
        
        .onAppear {
            userDelegate.userDidCompleteOnboarding()
        }
        
        
    }
    
    func mainWeatherDisplay() -> some View {
        
        let currentTemp = Degree(weatherInfo.currentWeather.temperatureFahrenheit)
        let lowTemp = Degree(weatherInfo.forecast.forecastday.first?.day.mintempF ?? 0.0 )
        let maxTemp = Degree(weatherInfo.forecast.forecastday.first?.day.maxtempF ?? 0.0 )
        
        
        
        return VStack {
            WPOTitle(weatherInfo.location.name, color: themeManager.currentTheme.textColor)
            Image(systemName: "sun.max.fill")
                .resizable()
                .frame(width: 35, height: 35)
                .foregroundColor(.yellow)
                .padding(.vertical, 5)
            WPOTitle(currentTemp.asString, color: themeManager.currentTheme.textColor)
            WPText(weatherInfo.currentWeather.condition.text, color: themeManager.currentTheme.textColor)
            WPText("L:\(lowTemp.asString) H:\(maxTemp.asString)", color: themeManager.currentTheme.textColor)
        }
    }
    
    func hourlyWeatherHStack() -> some View {
        let times: [(time: String, temp: Degree)] = [("12PM", Degree(58)),
                                                     ("1PM", Degree(60)),
                                                     ("2PM", Degree(60)),
                                                     ("3PM", Degree(63)),
                                                     ("4PM", Degree(63)),
                                                     ("5PM", Degree(63))]
        return ScrollView(.horizontal) {
            HStack {
                ForEach(0..<times.count, id: \.self) { time in
                    hourlyForecast(time: times[time].time,
                                   temp: times[time].temp.asString,
                                   theme: themeManager.currentTheme)
                }
                .padding(.horizontal, 5)
            }
            .padding(.horizontal, 10)
        }
    }
    
    func hourlyForecast(time: String, temp: String, theme: Theme) -> some View {
        return VStack {
            Text(time)
                .fontDesign(.rounded)
                .foregroundColor(theme.textColor)
            Image(systemName: "sun.max.fill")
                .resizable()
                .frame(width: 25, height: 25)
                .foregroundColor(.yellow)
                .padding(.vertical, 5)
            Text(temp)
                .fontDesign(.rounded)
                .foregroundColor(theme.textColor)
                .padding(.vertical, 5)
        }
    }
    
    func tenDayForecast() -> some View {
        TenDayTemperatureView(weatherInfo: weatherInfo)
    }

    
}




//
//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//        
//    }
//}


extension CLAuthorizationStatus {
    var name: String {
        switch self {
            case .notDetermined:
                return "notDetermined"
            case .restricted:
                return "restricted"
            case .denied:
                return "denied"
            case .authorizedAlways:
                return "authorizedAlways"
            case .authorizedWhenInUse:
                return "authorizedWhenInUse"
            case .authorized:
                return "authorized"
            default:
                return "Unknown"
        }
    }
}
