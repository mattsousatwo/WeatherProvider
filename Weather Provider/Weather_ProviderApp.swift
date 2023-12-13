//
//  Weather_ProviderApp.swift
//  Weather Provider
//
//  Created by Matthew Sousa on 5/10/23.
//

import SwiftUI

@available(iOS 17.0, *)
@main
struct Weather_ProviderApp: App {
    let themeManager = ThemeManager()
    let userDelegate = UserDelegate()
    
    init() {
        self.themeManager.currentTheme = userDelegate.theme
    }
    
    var body: some Scene {
        WindowGroup {
            SplashScreen()
                .environmentObject(themeManager)
                .environmentObject(userDelegate)
        }
    }
}
