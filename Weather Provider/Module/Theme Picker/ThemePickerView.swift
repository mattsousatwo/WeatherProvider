//
//  ThemePickerView.swift
//  Weather Provider
//
//  Created by Matthew Sousa on 5/19/23.
//

import SwiftUI

/// View used to select the users desired theme
@available(iOS 17.0, *)
struct ThemePickerView: View {
    @Environment(\.dismiss) var dismiss
    @State private var themeIndex: Int = 0
    @State private var currentTheme: Theme = ThemeList.one.theme
    @EnvironmentObject var userDelegate: UserDelegate
    
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
                    pageView()
                        .tag(3)
                }
                .tabViewStyle(PageTabViewStyle())
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                //                .frame(maxHeight: geo.size.height * 0.8, alignment: .center)
            } // VStack
        }// Geo
        .navigationBarBackButtonHidden(true)
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
                currentTheme = ThemeList.one.theme
            case 1:
                currentTheme = ThemeList.two.theme
            case 2:
                currentTheme = ThemeList.three.theme
            case 3:
                currentTheme = ThemeList.four.theme
            default:
                currentTheme = ThemeList.one.theme
        }
    }
    
    func pageView() -> some View {
        return VStack {
            WPOTitle("Choose a Theme", color: currentTheme.textColor)
            Spacer()
            WPOTitle(currentTheme.name, color: currentTheme.textColor)
            OnboardingWeatherDisplayView(theme: $currentTheme)
                .padding()
            Spacer()
            switch userDelegate.didCompleteOnboarding {
                case true:
                    WPButton("Select Theme",
                             theme: currentTheme) {
                        userDelegate.save(theme: currentTheme)
                        dismiss()
                    }
                case false:
                    WPNavigationLink(label: "Select Theme", theme: currentTheme) {
                        EnableLocationView()
                            .environmentObject(userDelegate)
                            .onAppear {

                                userDelegate.save(theme: currentTheme)
                                print("Theme Selected: \(currentTheme)")
                            }
                    }
            }
            Spacer()
        }
    }
    
}

//
//@available(iOS 17.0, *)
//struct ThemePickerView_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            ThemePickerView(themeIndex: 0, currentTheme: ThemeList.one.theme)
//            ThemePickerView(themeIndex: 1, currentTheme: ThemeList.two.theme)
//            ThemePickerView(themeIndex: 2, currentTheme: ThemeList.three.theme)
//            ThemePickerView(themeIndex: 3, currentTheme: ThemeList.four.theme)
//        }
//    }
//}
