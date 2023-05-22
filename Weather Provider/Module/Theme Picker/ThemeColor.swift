//
//  ThemeColor.swift
//  Weather Provider
//
//  Created by Matthew Sousa on 5/20/23.
//

import Foundation
import SwiftUI

/// Colors to be used during the Theme Selection
enum ThemeColor: Int {
    
    case one = 0
    case two = 1
    case three = 2 
    
    /// Color property of Theme
    var backgroundColor: Color {
        switch self {
            case .one:
                return .cyan
            case .two:
                return .purple
            case .three:
                return .indigo
        }
    }
    
    /// Color for the text
    var textColor: Color {
        switch self {
            case .one:
                return Color("TextColor")
            case .two:
                return Color("TextColor")
            case .three:
                return Color("TextColor")
        }
    }

    
}
