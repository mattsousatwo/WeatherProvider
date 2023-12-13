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
            switch viewState {
                case .loading:
                    weatherAnimation()
                        .onAppear {
                            if userDelegate.didCompleteOnboarding == true {
                                fetchData = true
                            } else {
                                fetchData = false
                            }
                        }
                case .failure(let reason):
                    VStack(alignment: .center, spacing: 20) {
                        WPText("Splash Screen - 1 - \(reason)", color: themeManager.currentTheme.textColor)
                        WPButton("Reload", theme: themeManager.currentTheme) {
                            runAnimation()
                        }
                    }
                    
                case .success:
                    if userDelegate.didCompleteOnboarding == true {
                        if let weatherInfo = weatherInfo {
                            HomeView(weatherInfo: weatherInfo)
                                .environmentObject(themeManager)
                                .environmentObject(userDelegate)
                        } else {
                            switch viewState {
                                case .failure(let reason):
                                    WPText("Splash Screen - 2 - \(reason)", color: themeManager.currentTheme.textColor)
                                default:
                                    Text("Splash Screen - default")
                            }
                            WPButton("Reload", theme: themeManager.currentTheme) {
                                runAnimation()
                            }
                            .onAppear {
                                fetchData = false
                                viewState = .failure(reason: "WeatherInfo failed to unwrap")
                            }
                        }
                        
                    } else if userDelegate.didCompleteOnboarding == false {
                        OnboardingView()
                            .environmentObject(themeManager)
                            .environmentObject(userDelegate)
                    }
            }
        }
        .onAppear {
            
                
            triggerLoadingAnimation()
            
            if userDelegate.didCompleteOnboarding == true &&
                locationManager.authorizationStatus == .authorizedWhenInUse ||
                locationManager.authorizationStatus == .authorizedAlways {
                // Fetch Weather Info
                fetchData = true
            }
            
            
        }
        .onChange(of: fetchData) { oldValue, newValue in
            if fetchData == true {
                Task(priority: .background) {
                    print("SplashScreen")
                    weatherInfo = try await weatherNetwork.fetchTenDayForecast(in: locationManager.longituteAndLatitude)
                }
            }
        }
        
        .onChange(of: viewState) { oldValue, newValue in
            switch viewState {
                case .loading:
                    fetchData = true
                default:
                    fetchData = false
            }
        }
        
        .onChange(of: weatherInfo) { oldValue, newValue in
            if weatherInfo == nil {
                viewState = .failure(reason: "WeatherInfo Failed to Load")
            } else {
                viewState = .success
            }
        }
        
        .onChange(of: locationManager.authorizationStatus) { oldValue, newValue in
            if locationManager.authorizationStatus == .authorizedWhenInUse {
                viewState = .loading
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
struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
