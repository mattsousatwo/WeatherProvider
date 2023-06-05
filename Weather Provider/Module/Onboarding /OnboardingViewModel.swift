//
//  OnboardingViewModel.swift
//  Weather Provider
//
//  Created by Matthew Sousa on 5/18/23.
//

import Foundation
import SwiftUI

/// View model for the Onboarding View
struct OnboardingViewModel: WPViewModel {
    
    
    
    /// Main body function for the Onbaording View - contains all of the views in the body of OnboardingView
    func mainBody(_ theme: Theme) -> some View  {
        NavigationStack {
            viewStructure(theme)
        }
    }
}

// Text Views
extension OnboardingViewModel {
    
    /// Text view with a heading for the onboarding
    private func welcomeHeadingText() -> some View {
        WPOTitle("Welcome to our Weather App!")
    }
    
    /// Text view with a heading for the onboarding
    private func welcomeMessageText() -> some View {
        WPText("Get accurate and up-to-date weather forecasts with our app. Plan your day with confidence. Our user-friendly app guides you through all its amazing features.")
            .multilineTextAlignment(.center)
    }
    
}

// Labels
extension OnboardingViewModel {
    
    /// Feature one label
    func featureOneLabel(_ theme: Theme) -> some View {
        WPLabel(title: "Accurate and Up-to-Date Forecasts",
                text: "Our app uses the weather data to provide you with the most accurate and reliable forecasts, so you can plan your day with confidence.",
                imageName: "sun.max.trianglebadge.exclamationmark",
                theme: theme)
    }
    
    /// Feature two label
    func featureTwoLabel(_ theme: Theme) -> some View {
        WPLabel(title: "Easy to Use",
                text: "With a user-friendly interface and intuitive design, our app makes it easy to navigate and access all of its amazing features.",
                imageName: "sparkles",
                theme: theme)
    }
    
    /// Feature three label
    func featureThreeLabel(_ theme: Theme) -> some View {
        WPLabel(title: "Customizable Settings",
                text: "You can customize the app to suit your preferences and get the weather information that matters the most to you.",
                imageName: "gear",
                theme: theme)
    }

}

// Buttons
extension OnboardingViewModel {
    
    /// Button used to dismiss the Onboarding View - should trigger an event that will save the user viewing the onboarding view so it will not be presented again
    func dismissOnboardingViewButton() -> some View {
//        NavigationLink(destination: ThemePickerView()) {
////            WPButton("Get Started!") {  }
//            WPText("Get Started")
//        }
        let themeManager = ThemeManager()
        return WPNavigationLink(label: "Get Started!") {
            ThemePickerView()
                .environmentObject(themeManager)
        }
    }
    
}


// Structure
extension OnboardingViewModel {
    
    /// View containing all of the messages within the Onboarding View
    internal func viewStructure(_ theme: Theme) -> some View  {
        return Background(theme) {
            VStack {
                onboardingHeading()
                Spacer()
                onboardingFeaturesList(theme)
                Spacer()
                dismissOnboardingViewButton()
                Spacer()
            }
            .padding()
        }
    }
    
    /// View stack with all of the onboarding heading messages
    private func onboardingHeading() -> some View {
        return VStack {
            welcomeHeadingText()
            welcomeMessageText()
        }
    }
    
    /// View stack with a list of onboarding features
    private func onboardingFeaturesList(_ theme: Theme) -> some View {
        VStack(alignment: .leading) {
            featureOneLabel(theme)
            featureTwoLabel(theme)
            featureThreeLabel(theme)
        }
    }
}


struct OnboardingViewModel_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
