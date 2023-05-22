//
//  ThemeList.swift
//  Weather Provider
//
//  Created by Matthew Sousa on 5/22/23.
//

import Foundation
import SwiftUI

/// List of themes to choose from
enum ThemeList {
    case defaultTheme
    case indigo
    case purple
    case teal
    
    
    
    
    
    var theme: Theme {
        switch self {
            case .defaultTheme:
                return Theme(name: "Default",
                             textColor: Color("TextColor"),
                             backgroundColor: Color("Background"),
                             accentColor: Color("Accent"))
            case .indigo:
                return Theme(name: "Name",
                             textColor: .white,
                             backgroundColor: .indigo,
                             accentColor: .yellow)
            case .purple:
                return Theme(name: "Name",
                             textColor: .white,
                             backgroundColor: .purple,
                             accentColor: .yellow)
            case .teal:
                return Theme(name: "Name",
                             textColor: .white,
                             backgroundColor: .teal,
                             accentColor: .yellow)
        }
    }


}
