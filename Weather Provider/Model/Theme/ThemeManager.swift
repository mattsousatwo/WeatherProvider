//
//  ThemeManager.swift
//  Weather Provider
//
//  Created by Matthew Sousa on 5/22/23.
//

import Foundation

/// File to control the theme of the application
class ThemeManager {
    
    var currentTheme: Theme
    
    init(currentTheme: Theme) {
        self.currentTheme = currentTheme
    }
    
}

extension ThemeManager {
    
    /// Sets the current theme to a new theme
    func updateCurrentTheme(with newTheme: Theme) {
        self.currentTheme = newTheme
    }
    
    
    
}
