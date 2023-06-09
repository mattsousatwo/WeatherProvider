//
//  WPOTitle.swift
//  Weather Provider
//
//  Created by Matthew Sousa on 5/19/23.
//

import SwiftUI

/// Title View used for the Weather Provider Onboarding view
struct WPOTitle: View {
    private let text: String
    private let color: Color
    init(_ text: String, color: Color = Color("TextColor")) {
        self.text = text
        self.color = color
    }
    var body: some View {
        welcomeHeadingText()
    }
    /// Text view with a heading for the onboarding
    private func welcomeHeadingText() -> some View {
        Text("**\(text)**")
            .foregroundColor(color)
            .multilineTextAlignment(.center)
            .font(.largeTitle)
            .fontDesign(.rounded)
            .padding(.bottom, 5)
            .padding(.top, 20)
    }
}

struct WPOTitle_Previews: PreviewProvider {
    static var previews: some View {
        Background {
            VStack {
                WPOTitle("Welcome to our Weather App!")
                WPOTitle("Select a Theme")
                WPOTitle("Location Services")
                WPOTitle("Fetching Weather...")
            }
        }
    }
}
