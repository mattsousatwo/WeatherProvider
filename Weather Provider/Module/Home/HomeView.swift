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
// MARK: -
                    HStack {
                        WPNavigationLink(label: "Add Location") {
                            LocationSearchView()
                                .environmentObject(themeManager)
                                .environmentObject(userDelegate)

                        }
                        Spacer()
                        WPNavigationLink(label: "Settings") {
                            SettingsView()
                                .environmentObject(themeManager)
                                .environmentObject(userDelegate)
                        }
                    }
                }
// MARK: -
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





@available(iOS 17.0, *)
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let weather = WeatherInfo(location: Location(name: "", region: "", country: "", latitude: 0.0, longitude: 0.0, timezoneID: "", localTimeEpoch: 0, localTime: ""),
                                  currentWeather: CurrentWeather(lastUpdatedEpoch: 1, lastUpdated: "", temperatureCelsius: 0.0, temperatureFahrenheit: 0.0, isDay: 1, condition: WeatherCondition(text: "", icon: "", code: 0), windMph: 0.0, windKph: 0.0, windDegree: 0, windDirection: "", pressureMb: 0.0, pressureIn: 0.0, precipitationMm: 0.0, precipitationIn: 0.0, humidity: 0, cloudCover: 0, feelsLikeCelsius: 0.0, feelsLikeFahrenheit: 0.0, visibilityKm: 0.0, visibilityMiles: 0.0, uvIndex: 0.0, gustMph: 0.0, gustKph: 0.0, airQuality: nil),
                                  forecast: Forecast(forecastday: [Forecastday(date: "", dateEpoch: 0, day: Day(maxtempC: 0.0, maxtempF: 0.0, mintempC: 0.0, mintempF: 0.0, avgtempC: 0.0, avgtempF: 0.0, maxwindMph: 0.0, maxwindKph: 0.0, totalprecipMm: 0.0, totalprecipIn: 0.0, totalsnowCM: 0.0, avgvisKM: 0.0, avgvisMiles: 0.0, avghumidity: 0.0, dailyWillItRain: 0, dailyChanceOfRain: 0, dailyWillItSnow: 0, dailyChanceOfSnow: 0, condition: Condition(text: "", icon: "", code: 1), uv: 1), astro: Astro(sunrise: "", sunset: "", moonrise: "", moonset: "", moonPhase: "", isMoonUp: 0, isSunUp: 1, moonIllumination: 1), hour: [Hour(timeEpoch: 1, time: "", tempC: 0.0, tempF: 0.0, isDay: 0, condition: Condition(text: "", icon: "", code: 1), windMph: 0.0, windKph: 0.0, windDegree: 0, windDir: "", pressureMB: 0, pressureIn: 0.0, precipMm: 0.0, precipIn: 0.0, humidity: 0, cloud: 0, feelslikeC: 0.0, feelslikeF: 0.0, windchillC: 0.0, windchillF: 0.0, heatindexC: 0.0, heatindexF: 0.0, dewpointC: 0.0, dewpointF: 0.0, willItRain: 0, chanceOfRain: 0, willItSnow: 0, chanceOfSnow: 0, visKM: 0, visMiles: 0, gustMph: 0.0, gustKph: 0.0, uv: 0)])]))
        HomeView(weatherInfo: weather)
            .environmentObject(ThemeManager() )
            .environmentObject(UserDelegate() )
        
    }
}

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
