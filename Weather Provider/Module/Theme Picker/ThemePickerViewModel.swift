//
//  ThemePickerViewModel.swift
//  Weather Provider
//
//  Created by Matthew Sousa on 5/19/23.
//

import Foundation
import SwiftUI

/// View Model for the Theme Selection page in the Onboarding View Module 
struct ThemePickerViewModel: WPViewModel {
    
    func mainBody() -> some View {
        viewStructure()
    }
    
    internal func viewStructure() -> some View {
        Background {
            VStack {
                pickerHeading()
                Spacer()
                themePicker()
                Spacer()
                WPNavigationLink(label: "Next Page") {
                    Text("Next Page")
                }
                Spacer()
            }
        }
    }
}

/// Views
extension ThemePickerViewModel {
    
    /// Heading for the Theme Picker
    private func pickerHeading() -> some View {
        WPOTitle("Choose a Theme")
    }
    
    /// Frame used to select the theme 
    private func themePicker() -> some View {
        return RoundedRectangle(cornerRadius: 12)
            .frame(width: UIScreen.main.bounds.width / 2 + 100,
                   height: UIScreen.main.bounds.height / 2)
            .foregroundColor(Color("Accent"))
    }
}
