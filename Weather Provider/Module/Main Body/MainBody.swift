//
//  MainBody.swift
//  Weather Provider
//
//  Created by Matthew Sousa on 12/11/23.
//

import SwiftUI

@available(iOS 17.0, *)
struct MainBody: View {
    
    @EnvironmentObject var themeManager: ThemeManager
    @EnvironmentObject var userDelegate: UserDelegate
    
    
    var didCompleteOnboarding: Bool
    
    var body: some View {
        
        Background(themeManager.currentTheme) {
            
            switch userDelegate.didCompleteOnboarding {
                case true:
                    FetchingDataView()
                    //                    HomeView(, weatherInfo: <#WeatherInfo#>)
                        .environmentObject(themeManager)
                        .environmentObject(userDelegate)
                        .onAppear {
                            themeManager.currentTheme = userDelegate.theme
                        }
                    
                case false:
                    OnboardingView()
                        .environmentObject(themeManager)
                        .environmentObject(userDelegate)
                        .onAppear {
                            themeManager.currentTheme = userDelegate.theme
                        }
                    
            }
            
            
            

        }
    }
}

#Preview {
    if #available(iOS 17.0, *) {
        MainBody(didCompleteOnboarding: false)
    } else {
        // Fallback on earlier versions
        Text("Hello")
    }
}
