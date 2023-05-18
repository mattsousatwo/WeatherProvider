//
//  OnboardingView.swift
//  Weather Provider
//
//  Created by Matthew Sousa on 5/18/23.
//

import SwiftUI

/// Onboarding view to display a message to the user to describe the functionality of the application
struct OnboardingView: View {
    
    let viewModel = OnboardingViewModel()
    
    var body: some View {
        
        viewModel.mainBody()
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
