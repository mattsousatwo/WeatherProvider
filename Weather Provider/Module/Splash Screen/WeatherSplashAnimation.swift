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
    private let imageSize: CGFloat = 80
    
    
    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0, to: 0.2)
                .stroke(theme.weatherBackground, style: .init(lineWidth: 10, lineCap: .round))
                .frame(width: 140, height: 140)
                .rotationEffect(Angle(degrees: isActive ? 1080 : 0))
                .shadow(radius: 2, x: 0, y: 1)
                .animation(Animation.linear(duration: 5), value: isActive)
            Image(systemName: "sun.max.fill")
                .resizable()
                .frame(width: imageSize, height: imageSize)
                .foregroundColor(theme.accentColor.opacity(0.75) )
                .shadow(radius: 4, x: 0, y: 1)
        }
    }
}

#Preview {
    Background(ThemeList.four.theme) {
        WeatherSplashAnimation(isActive: .constant(true), theme: ThemeList.four.theme)
    }
}
