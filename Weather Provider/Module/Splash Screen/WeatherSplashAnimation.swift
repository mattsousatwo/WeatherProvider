//
//  WeatherSplashAnimation.swift
//  Weather Provider
//
//  Created by Matthew Sousa on 12/12/23.
//

import SwiftUI

/// Loading Animation - Sun inside a roatating loading circle
struct WeatherSplashAnimation: View {
    
    @Binding var isActive: Bool
    var theme: Theme
    
    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0, to: 0.2)
                .stroke(theme.weatherBackground, style: .init(lineWidth: 10, lineCap: .round))
                .frame(width: 125, height: 125)
                .rotationEffect(Angle(degrees: isActive ? 1080 : 0))
                .animation(Animation.linear(duration: 5), value: isActive)
            Image(systemName: "sun.max.fill")
                .resizable()
                .frame(width: 65, height: 65)
                .foregroundColor(theme.accentColor.opacity(0.85))
        }
    }
}

#Preview {
    Background(ThemeList.two.theme) {
        WeatherSplashAnimation(isActive: .constant(true), theme: ThemeList.two.theme)
    }
}
