//
//  FetchingDataView.swift
//  Weather Provider
//
//  Created by Matthew Sousa on 5/26/23.
//

import SwiftUI

/// View to display a loading animation between the Home and Onboarding Views 
struct FetchingDataView: View {
    @EnvironmentObject var themeManager: ThemeManager
    var body: some View {
        Background(themeManager.currentTheme) {
            VStack {
                Spacer()
                WPNavigationLink(label: "Go to Home", theme: themeManager.currentTheme) {
                    HomeView()
                        .environmentObject(themeManager)
                }
                Spacer()
            }
        }
        
    }
}

struct FetchingDataView_Previews: PreviewProvider {
    static var previews: some View {
        FetchingDataView()
    }
}
