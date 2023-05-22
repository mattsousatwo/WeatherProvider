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
    @ViewBuilder var destination: Destination
    
    init(label: String, @ViewBuilder destination: () -> Destination) {
        self.label = label
        self.destination = destination()
    }
    
    var body: some View {
        NavigationLink(destination: destination) {
            Text(label)
                .fontWeight(.medium)
                .foregroundColor(Color("TextColor"))
                .foregroundColor(.white)
                .padding()
                .frame(width: 225)
                .background(Color("Accent"))
                .cornerRadius(12)
        }
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
