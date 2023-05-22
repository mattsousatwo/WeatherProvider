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
        ThemePagePicker()
            
        
    }
    
    internal func viewStructure() -> some View {
        Background {
            VStack {
                pickerHeading()
                Spacer()
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
    internal func pickerHeading() -> some View {
        WPOTitle("Choose a Theme")
    }
    
}



struct ThemePickerViewModel_Previews: PreviewProvider {
    static var previews: some View {
        ThemePickerView()
    }
}



