//
//  ThemeManager.swift
//  Weather Provider
//
//  Created by Matthew Sousa on 5/22/23.
//

import Foundation
import SwiftUI

/// File to control the theme of the application
class ThemeManager: ObservableObject {
    

    @Published var currentTheme: Theme
    
    init(currentTheme: Theme) {
        self.currentTheme = currentTheme
    }
    
    init() {
 
        self.currentTheme = ThemeList.one.theme
        

    }
    
}

extension ThemeManager {
    
    /// Sets the current theme to a new theme
    func updateCurrentTheme(with newTheme: Theme) {
        self.currentTheme = newTheme
    }
    
    
    
}
