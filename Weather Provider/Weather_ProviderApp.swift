//
//  Weather_ProviderApp.swift
//  Weather Provider
//
//  Created by Matthew Sousa on 5/10/23.
//

import SwiftUI

@main
struct Weather_ProviderApp: App {
    let themeManager = ThemeManager()
    
    var body: some Scene {
        WindowGroup {
            OnboardingView()
                .environmentObject(themeManager)
        }
    }
}
