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
    @EnvironmentObject var userDelegate: UserDelegate
    
    @StateObject var locationManager = LocationManager()
    
    var weatherData: [WeatherInfo] = []
    let currentDay = Date().dateComponents
    let hoursMax = 31
    
    @State var viewState: ViewState = .loading
    
    /// View Model for the Home Module
    let viewModel = HomeViewModel()
    
    @State private var locationIndex: Int = 0
    @State private var hourlyIndex: Int = 0
    
    var body: some View {
        NavigationStack {
            Background(userDelegate.theme) {
                TabView(selection: $locationIndex) {
                    ForEach(0..<weatherData.count,
                            id: \.self) { index in
                        tabViewBody(weatherData[index])
                            .tag(index)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .toolbar {
                    ToolbarItemGroup(placement: .bottomBar) {
                        settingsButton()
                        Spacer()
                        PageNavigationView(numberOfPages: weatherData.count,
                                           currentIndex: $locationIndex)
                        Spacer()
                        locationSearchButton()
                    }
                }


            }
        }
        .tint(userDelegate.theme.accentColor)
        .redacted(reason: viewState != .success ? .placeholder : [])
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
        .onChange(of: locationManager.authorizationStatus) { oldValue, newValue in
            switch locationManager.authorizationStatus {
                case .authorized, .authorizedAlways, .authorizedWhenInUse:
                    // Location has been enabled
                    viewState = .success
                default:
                    break
            }
            
            
        }
        
        
        
        
    }

}


@available(iOS 17.0, *)
extension HomeView {
    
    func tabViewBody(_ weather: WeatherInfo) -> some View {
        ZStack {
            switch viewState {
                case .loading:
                    ProgressView()
                case .failure(let reason):
                    Text("Failure - \(reason)")
                case .success:
                    viewStructure(weather)
            }
        }

    }
    
    func buttonRow() -> some View {
        HStack {
            locationSearchButton()

            Spacer()
            
            settingsButton()
        }

    }

    func locationSearchButton() -> some View {
        NavigationLink {
            LocationSearchView()
                .environmentObject(userDelegate)
        } label: {
            Image(systemName: "magnifyingglass")
                .resizable()
                .frame(width: 25, height: 25)
                .padding(5)
        }
    }

    func settingsButton() -> some View {
        NavigationLink {
            SettingsView()
                .environmentObject(userDelegate)
        } label: {
            Image(systemName: "gearshape")
                .resizable()
                .frame(width: 25, height: 25)
                .padding(5)
                
        }
    }

    
    
    func viewStructure(_ weather: WeatherInfo) -> some View {
           return ScrollView(.vertical) {
                VStack {
                    if viewState == .success {
                        mainWeatherDisplay(weather)

                        WeatherHighlights(weather: weather)
                            .environmentObject(userDelegate)
                        
                        let hourCollection = configureHourly(weather: weather)
                        
                            ScrollView(.horizontal) {
                                HStack {
                                    ForEach(0..<hourCollection.count, id: \.self) { index in
                                            hourlyForecast(for: hourCollection[index],
                                                           index: index,
                                                           theme: userDelegate.theme)
                                    }
                                    .padding(.horizontal, 5)
                                }
                                .padding(.horizontal, 10)
                            }
                            .scrollIndicators(.hidden)
                        tenDayForecast()
                    }
                    Spacer()
                }
            }
        
        .onAppear {
            userDelegate.userDidCompleteOnboarding()
        }
        
        
    }
    
    func configureHourly(weather: WeatherInfo) -> [Hour] {
        let everyHourPerDay = weather.forecast.forecastday[0].hour + weather.forecast.forecastday[1].hour + weather.forecast.forecastday[2].hour
        var filteredHours: [Hour] = []
        if everyHourPerDay.count > hoursMax {
            for index in 0..<hoursMax {
                var hoursCount = 0
                let components = everyHourPerDay[index].dataComponents
                if currentDay.day == components.day { // Same Day
                    if currentDay.hour == components.hours { // same hour
                        filteredHours.append(everyHourPerDay[index])
                        hoursCount += 1
                    } else if currentDay.hour < components.hours { // later hour
                        filteredHours.append(everyHourPerDay[index])
                        hoursCount += 1
                    } else { // earlier hour
                        
                    }
                } else { // next day
                    filteredHours.append(everyHourPerDay[index])
                    hoursCount += 1
                }
            }
        }
        return filteredHours
    }
    
    
    
    func mainWeatherDisplay(_ weather: WeatherInfo) -> some View {
        let currentTemp = Degree(weather.currentWeather.temperatureFahrenheit)
        let lowTemp = Degree(weather.forecast.forecastday.first?.day.mintempF ?? 0.0 )
        let maxTemp = Degree(weather.forecast.forecastday.first?.day.maxtempF ?? 0.0 )
        let title = weather.location.name
        
        
        return VStack {
            WPOTitle(title, color: userDelegate.theme.textColor)
                .padding(.top, 15)
                .shadow(radius: 1, x: 0, y: 1)
            weather.currentWeather.condition.image()
                .resizable()
                .frame(width: 70, height: 70)
                .foregroundColor(userDelegate.theme.accentColor)
                .padding(.vertical, 5)
                .shadow(radius: 1, x: 0, y: 1)
            WPOTitle(currentTemp.asString, color: userDelegate.theme.textColor)
                .shadow(radius: 1, x: 0, y: 1)
            WPText(weather.currentWeather.condition.text , color: userDelegate.theme.textColor)
                .shadow(radius: 1, x: 0, y: 1)
            WPText("L:\(lowTemp.asString) H:\(maxTemp.asString)", color: userDelegate.theme.textColor)
                .shadow(radius: 1, x: 0, y: 1)
        }
    }
    
//    r
    
    func hourlyForecast(for day: Hour, index: Int, theme: Theme) -> some View {
        var title: String = "Time"
        var isBold: Bool = false
        
        if let twelveHourTime = day.twelveHourTime {
            switch twelveHourTime {
                case "12:00 PM":
                    title = "Noon"
                    isBold = true
                case "12:00 AM":
                    if index != 0 {
                        if let daysName = day.daysName {
                            title = daysName
                            isBold = true
                        }
                    } else {
                        title = "Now"
                        isBold = true
                    }
                default:
                    title = twelveHourTime
                    isBold = false
            }
        } else {
            title = day.time
        }
        
         
        
        
        return VStack {
            Text(title)
                .fontDesign(.rounded)
                .foregroundColor(theme.textColor)
                .bold(isBold == true ? true: false)
                .shadow(radius: isBold == true ? 1 : 0, x: 0, y: 1)
            day.condition.image()
                .resizable()
                .frame(width: 25, height: 25)
                .foregroundColor(userDelegate.theme.accentColor)
                .padding(.vertical, 5)
            Text(Degree(day.tempF).asString)
                .fontWeight(.light)
                .fontDesign(.rounded)
                .foregroundColor(theme.textColor)
                .padding(.vertical, 5)
        }
    }
    
    func tenDayForecast() -> some View {
        TenDayTemperatureView(weatherInfo: weatherData[locationIndex])
    }

    
}





@available(iOS 17.0, *)
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let weather = WeatherInfo(location: Location(name: "", region: "", country: "", latitude: 0.0, longitude: 0.0, timezoneID: "", localTimeEpoch: 0, localTime: ""),
                                  currentWeather: CurrentWeather(lastUpdatedEpoch: 1, lastUpdated: "", temperatureCelsius: 0.0, temperatureFahrenheit: 0.0, isDay: 1, condition: Condition(text: "", icon: "", code: 0), windMph: 0.0, windKph: 0.0, windDegree: 0, windDirection: "", pressureMb: 0.0, pressureIn: 0.0, precipitationMm: 0.0, precipitationIn: 0.0, humidity: 0, cloudCover: 0, feelsLikeCelsius: 0.0, feelsLikeFahrenheit: 0.0, visibilityKm: 0.0, visibilityMiles: 0.0, uvIndex: 0.0, gustMph: 0.0, gustKph: 0.0, airQuality: nil),
                                  forecast: Forecast(forecastday: [Forecastday(date: "", dateEpoch: 0, day: Day(maxtempC: 0.0, maxtempF: 0.0, mintempC: 0.0, mintempF: 0.0, avgtempC: 0.0, avgtempF: 0.0, maxwindMph: 0.0, maxwindKph: 0.0, totalprecipMm: 0.0, totalprecipIn: 0.0, totalsnowCM: 0.0, avgvisKM: 0.0, avgvisMiles: 0.0, avghumidity: 0.0, dailyWillItRain: 0, dailyChanceOfRain: 0, dailyWillItSnow: 0, dailyChanceOfSnow: 0, condition: Condition(text: "", icon: "", code: 1), uv: 1), astro: Astro(sunrise: "", sunset: "", moonrise: "", moonset: "", moonPhase: "", isMoonUp: 0, isSunUp: 1, moonIllumination: 1), hour: [Hour(timeEpoch: 1, time: "", tempC: 0.0, tempF: 0.0, isDay: 0, condition: Condition(text: "", icon: "", code: 1), windMph: 0.0, windKph: 0.0, windDegree: 0, windDir: "", pressureMB: 0, pressureIn: 0.0, precipMm: 0.0, precipIn: 0.0, humidity: 0, cloud: 0, feelslikeC: 0.0, feelslikeF: 0.0, windchillC: 0.0, windchillF: 0.0, heatindexC: 0.0, heatindexF: 0.0, dewpointC: 0.0, dewpointF: 0.0, willItRain: 0, chanceOfRain: 0, willItSnow: 0, chanceOfSnow: 0, visKM: 0, visMiles: 0, gustMph: 0.0, gustKph: 0.0, uv: 0)])]))
        HomeView(weatherData: [weather])
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
