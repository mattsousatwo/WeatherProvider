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
    let userDelegate = UserDelegate()
    
    var body: some Scene {
        WindowGroup {
            SplashScreen()
                .environmentObject(userDelegate)
        }
    }
}
