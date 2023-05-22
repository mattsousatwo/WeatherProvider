//
//  ThemePagePicker.swift
//  Weather Provider
//
//  Created by Matthew Sousa on 5/20/23.
//

import Foundation
import SwiftUI

struct ThemePagePicker: View {
    @State var themeIndex: Int = 0
    @State var currentTheme: Theme = ThemeList.defaultTheme.theme
    
    var body: some View {
        themePagePicker()
    }
    
    /// View to return a page style tab view for the user to select a new theme with
    private func themePagePicker() -> some View {
        GeometryReader { geo in
            VStack {
                TabView(selection: $themeIndex) {
                    pageView()
                        .tag(0)
                    pageView()
                        .tag(1)
                    pageView()
                        .tag(2)
                }
                .tabViewStyle(PageTabViewStyle())
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                .frame(maxHeight: geo.size.height * 0.8, alignment: .center)
            } // VStack
            
        }// Geo
        .background(
            currentTheme.backgroundColor
                .edgesIgnoringSafeArea(.all)
        )
        .onChange(of: themeIndex) { _ in
            withAnimation(.easeInOut(duration: 0.8)) {
                switchColor()
            }
        }
        
    } // Func
    
    /// Function to control the background color
    func switchColor() {
        switch themeIndex {
            case 0:
                currentTheme = ThemeList.defaultTheme.theme
            case 1:
                currentTheme = ThemeList.indigo.theme
            case 2:
                currentTheme = ThemeList.purple.theme
            default:
                currentTheme = ThemeList.teal.theme
        }
    }
    
    func pageView() -> some View {
        return VStack {
            WPOTitle("Choose a Theme")
            OnboardingWeatherDisplayView(theme: $currentTheme)
                .padding()
        }
        
    }
    
}





struct ThemePagePicker_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ThemePagePicker(themeIndex: 0)
            ThemePagePicker(themeIndex: 1)
            ThemePagePicker(themeIndex: 2)
        }
    }
}
