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
    
    @EnvironmentObject var themeManager: ThemeManager
    @EnvironmentObject var userDelegate: UserDelegate
    
    @State private var isAppLoaded: Bool = false
    @State private var loadingAnimationIsActive: Bool = false

    @ObservedObject var weatherNetwork = WeatherNetwork()
    @State private var weatherInfo: WeatherInfo? = nil
    
//    @StateObject var locationManager = LocationManager()
    let locationManager = CLLocationManager()
    
    @State var viewState: ViewState = .loading
    
    // to trigger when to fetch data
    @State var fetchData: Bool = false
    
    
    var body: some View {
        Background(themeManager.currentTheme) {
            switch userDelegate.didCompleteOnboarding {
                case true:
                    switch viewState {
                        case .loading:
                            completeOnboardingLoading()
                        case .failure(let reason):
                            completeOnboardingFailure(reason)
                        case .success:
//                            completeOnboardingSuccess()
                            if let weatherInfo = weatherInfo {
                                HomeView(weatherInfo: weatherInfo)
                                    .environmentObject(themeManager)
                                    .environmentObject(userDelegate)
                            } else {
                                completeOnboardingFailure("Failed to unwrap WeatherInfo - \(locationManager.authorizationStatus)")
                            }

                    }
                case false:
                    switch viewState {
                        case .loading:
                            incompleteOnboardingLoading()
                        case .failure(let reason):
                            incompleteOnboardingFailure(reason)
                        case .success:
//                            incompleteOnboardingSuccess()
                            OnboardingView()
                                .environmentObject(themeManager)
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
                    weatherInfo = try await weatherNetwork.fetchTenDayForecast(in: locationManager.longituteAndLatitude)
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
        WeatherSplashAnimation(isActive: $loadingAnimationIsActive, theme: themeManager.currentTheme)
        .onChange(of: weatherInfo) {
//            self.isAppLoaded = true
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
                //                    self.isAppLoaded = true
                self.viewState = .success
                self.loadingAnimationIsActive = false
            }
        }
    }
    
}



@available(iOS 17.0, *)
extension SplashScreen {
    
    func incompleteOnboardingLoading() -> some View {
//        WPText("Splash 2", color: themeManager.currentTheme.textColor)
        weatherAnimation()
    }
    
    func incompleteOnboardingFailure(_ reason: String) -> some View {
        WPText("Splash 4 - \(reason)", color: themeManager.currentTheme.textColor)
    }
    
    // --------------------------
    
    func completeOnboardingLoading() -> some View {
        //        WPText("Splash 1", color: themeManager.currentTheme.textColor)
        weatherAnimation()
    }
    
    func completeOnboardingFailure(_ reason: String) -> some View {
        locationManager.requestWhenInUseAuthorization()
//        return WPText("Splash 3 - \(reason)", color: themeManager.currentTheme.textColor)
        return WPButton("Splash 3 - \(reason)",
                        theme: themeManager.currentTheme) {
            runAnimation()
        }
    }
    
}





@available(iOS 17.0, *)
struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}




//switch viewState {
//    case .loading:
//        weatherAnimation()
//            .onAppear {
//                if userDelegate.didCompleteOnboarding == true {
//                    fetchData = true
//                } else {
//                    fetchData = false
//                }
//            }
//        // MARK: -
//    case .failure(let reason):
//        VStack(alignment: .center, spacing: 20) {
//            WPText("Splash Screen - 1 - \(reason)", color: themeManager.currentTheme.textColor)
//            WPButton("Reload", theme: themeManager.currentTheme) {
//                runAnimation()
//            }
//        }
//        // MARK: -
//    case .success:
//        if userDelegate.didCompleteOnboarding == true {
//            if let weatherInfo = weatherInfo {
//                HomeView(weatherInfo: weatherInfo)
//                    .environmentObject(themeManager)
//                    .environmentObject(userDelegate)
//            } else {
//                // MARK: -
//                switch viewState {
//                    case .failure(let reason):
//                        WPText("Splash Screen - 2 - \(reason)", color: themeManager.currentTheme.textColor)
//                    default:
//                        Text("Splash Screen - default")
//                }
//                WPButton("Reload", theme: themeManager.currentTheme) {
//                    runAnimation()
//                }
//                .onAppear {
//                    fetchData = false
//                    viewState = .failure(reason: "WeatherInfo failed to unwrap")
//                }
//                // MARK: -
//            }
//            
//        } else if userDelegate.didCompleteOnboarding == false {
//            OnboardingView()
//                .environmentObject(themeManager)
//                .environmentObject(userDelegate)
//        }
//    }
