//
//  Background.swift
//  Weather Provider
//
//  Created by Matthew Sousa on 5/17/23.
//

import SwiftUI

/// Background is a ZStack with the background color embedded inside it 
struct Background<Content: View>: View {
    @ViewBuilder var content: Content
    let theme: Theme
    
    private let displayType: BackgroundDisplayType
    private let overlayOffset: CGFloat = 0
    private let layerSize: CGFloat = UIScreen.main.bounds.height / 2
    
    init(displayType: BackgroundDisplayType = .one, _ theme: Theme = ThemeList.four.theme, @ViewBuilder content: () -> Content) {
        self.displayType = displayType
        self.theme = theme
        self.content = content()
    }
    
    
    var body: some View {
        ZStack() {
            theme.backgroundColor
                .ignoresSafeArea(.all)
                .overlay(alignment: .topTrailing) {
                    RoundedRectangle(cornerRadius: 0)
                        .ignoresSafeArea(.all)
                        .frame(height: layerSize)
                        .foregroundStyle(theme.weatherBackground)
                        .roundedCorner(displayType == .one ? 200 : 0, corners: .bottomRight)
                        .shadow(radius: 5)
                        .offset(y: overlayOffset)
                        .ignoresSafeArea(.all)
                        .overlay(alignment: .center) {
                            RoundedRectangle(cornerRadius: 0)
                                .ignoresSafeArea(.all)
                                .frame(height: layerSize)
                                .foregroundStyle(.black)
                                .roundedCorner(displayType == .one ? 200 : 0, corners: .bottomRight)
                                .opacity(0.05)
                                .offset(y: overlayOffset)
                                .ignoresSafeArea(.all)
                        }
                }
            content
        }
    }
}

struct Background_Previews: PreviewProvider {
    static var previews: some View {
        Background {
//            WeatherHighlights()
//                .environmentObject(UserDelegate() )
            TemporaryWeatherDisplay(theme: ThemeList.four.theme)
                .padding()
                .shadow(radius: 5)
        }
    }
}

enum BackgroundDisplayType {
    /// Will produce a rounded background
    case one
    /// Will produce a straight background
    case two
}
