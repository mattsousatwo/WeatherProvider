//
//  SplashScreen.swift
//  Weather Provider
//
//  Created by Matthew Sousa on 5/18/23.
//

import SwiftUI
import CoreLocation

@available(iOS 17.0, *)
struct SplashScreen: View {
    @EnvironmentObject var userDelegate: UserDelegate
    
    @State private var isAppLoaded: Bool = false
    @State private var loadingAnimationIsActive: Bool = false

    @ObservedObject var weatherNetwork = WeatherNetwork()
    @State private var weatherInfo: WeatherInfo? = nil
    
    @State private var weatherData: [WeatherInfo] = []
    
    let locationManager = CLLocationManager()
    
    @State var viewState: ViewState = .loading
    
    // to trigger when to fetch data
    @State var fetchData: Bool = false
    
    
    var body: some View {
        Background(userDelegate.theme) {
            switch userDelegate.didCompleteOnboarding {
                case true:
                    switch viewState {
                        case .loading:
                            completeOnboardingLoading()
//                        case .failure(let reason):
//                            completeOnboardingFailure(reason)
                        case .failure(_), .success:
                            HomeView(weatherData: weatherData)
                                .environmentObject(userDelegate)
                    }
                case false:
                    switch viewState {
                        case .loading:
                            incompleteOnboardingLoading()
                        case .failure(let reason):
                            incompleteOnboardingFailure(reason)
                        case .success:
                            OnboardingView()
                                .environmentObject(userDelegate)
                    }
            }
        }
        .onAppear {
            triggerLoadingAnimation()
        }
        .onChange(of: fetchData) { oldValue, newValue in
            if fetchData == true && 
                userDelegate.didCompleteOnboarding == true &&
                locationManager.authorizationStatus == .authorizedWhenInUse {
                Task(priority: .background) {
                    print("SplashScreen - Fetch WeatherInfo - ")
                    print("Splash Screen - AuthStatus: \(locationManager.authorizationStatus) -")
                    for location in userDelegate.savedLocations {
                        if let fetchedWeatherResults = try await weatherNetwork.fetchTenDayForecast(in: location.longituteAndLatitude) {
                            weatherData.append(fetchedWeatherResults)
                        }
                    }
//                    weatherInfo = try await weatherNetwork.fetchTenDayForecast(in: locationManager.longituteAndLatitude)
                }
            }
        }
        
        .onChange(of: viewState) { oldValue, newValue in
            switch viewState {
                case .loading:
                    if userDelegate.didCompleteOnboarding == true {
                        fetchData = true
                    }
                default:
                    fetchData = false
            }
        }
        
        .onChange(of: weatherInfo) { oldValue, newValue in
            guard let weatherInfo = weatherInfo else {
                viewState = .failure(reason: "WeatherInfo Failed to Load")
                return
            }
            viewState = .success
            userDelegate.save(location: weatherInfo.location)
            

        }
        
        .onChange(of: locationManager.authorizationStatus) { oldValue, newValue in
            print("Authorization Status Change - \(newValue)")
            if locationManager.authorizationStatus == .authorizedWhenInUse {
                viewState = .loading
            }
        }
        
        .onChange(of: userDelegate.didCompleteOnboarding) {
            if userDelegate.didCompleteOnboarding == true &&
                locationManager.authorizationStatus == .authorizedWhenInUse ||
                locationManager.authorizationStatus == .authorizedAlways {
                // Fetch Weather Info
                viewState = .loading
//                fetchData = true
            }
        }
        
        
    }
}

@available(iOS 17.0, *)
extension SplashScreen {
    
    func weatherAnimation() -> some View {
        WeatherSplashAnimation(isActive: $loadingAnimationIsActive, theme: userDelegate.theme)
        .onChange(of: weatherInfo) {
            self.loadingAnimationIsActive = false
        }
    }

    func runAnimation() {
        self.isAppLoaded = false
        self.loadingAnimationIsActive = true
        self.viewState = .loading
        self.fetchData = true
    }
    
    func stopAnimation() {
        self.isAppLoaded = true
        self.loadingAnimationIsActive = false
        self.viewState = .success
        self.fetchData = false
    }
    
    func triggerLoadingAnimation() {
        runAnimation()
        // After 2.3 sec cancel loading animation
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.3) {
            withAnimation {
                self.viewState = .success
                self.loadingAnimationIsActive = false
            }
        }
    }
    
}



@available(iOS 17.0, *)
extension SplashScreen {
    
    func incompleteOnboardingLoading() -> some View {
        weatherAnimation()
    }
    
    func incompleteOnboardingFailure(_ reason: String) -> some View {
        WPText("Splash 4 - \(reason)", color: userDelegate.theme.textColor)
    }
    
    // --------------------------
    
    func completeOnboardingLoading() -> some View {
        weatherAnimation()
    }
    
    func completeOnboardingFailure(_ reason: String) -> some View {
        locationManager.requestWhenInUseAuthorization()
        return WPButton("Splash 3 - \(reason)",
                        theme: userDelegate.theme) {
            runAnimation()
        }
    }
    
}

@available(iOS 17.0, *)
extension SplashScreen {
    

    
}



@available(iOS 17.0, *)
struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
