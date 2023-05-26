//
//  WPNavigationLink.swift
//  Weather Provider
//
//  Created by Matthew Sousa on 5/19/23.
//

import SwiftUI

/// Navigation Link to be used in place of NavigationLink - Is approved by WP guidelines
struct WPNavigationLink<Destination: View>: View {
    let label: String
    let theme: Theme
    @ViewBuilder var destination: Destination
    var action: () -> Void
    
    init(label: String, theme: Theme = ThemeList.one.theme, @ViewBuilder destination: () -> Destination, action: @escaping () -> Void = {} ) {
        self.label = label
        self.destination = destination()
        self.theme = theme
        self.action = action
    }
    
    var body: some View {
        NavigationLink(destination: destination) {
            navigationLabel()
        }
        
    }
    
    func navigationLabel() -> some View {
        Text(label)
            .fontWeight(.medium)
            .foregroundColor(theme.textColor)
            .foregroundColor(.white)
            .padding()
            .frame(width: 225)
            .background(theme.weatherBackground)
            .cornerRadius(12)

    }
}
struct WPNavigationLink_Previews: PreviewProvider {
    static var previews: some View {
        Background {
            WPNavigationLink(label: "Get Started!") {
                WPOTitle("New View")
            }
        }
    }
}
