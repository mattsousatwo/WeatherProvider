//
//  OnboardingView.swift
//  Weather Provider
//
//  Created by Matthew Sousa on 5/18/23.
//

import SwiftUI

/// Onboarding view to display a message to the user to describe the functionality of the application
struct OnboardingView: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    let viewModel = OnboardingViewModel()
    
    var body: some View {
        
        viewModel.mainBody(themeManager.currentTheme)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
