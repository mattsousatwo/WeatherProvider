//
//  OnboardingView.swift
//  Weather Provider
//
//  Created by Matthew Sousa on 5/18/23.
//

import SwiftUI

/// Onboarding view to display a message to the user to describe the functionality of the application
@available(iOS 17.0, *)
struct OnboardingView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @EnvironmentObject var userDelegate: UserDelegate
    
    let viewModel = OnboardingViewModel()
    
    var body: some View {
        
        viewModel.mainBody(themeManager.currentTheme)
    }
}

@available(iOS 17.0, *)
struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
