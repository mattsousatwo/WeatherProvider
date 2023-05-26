//
//  ThemeList.swift
//  Weather Provider
//
//  Created by Matthew Sousa on 5/22/23.
//

import Foundation
import SwiftUI

/// List of themes to choose from
enum ThemeList: CaseIterable {
    case one
    case two
    case three
    case four
    
    var theme: Theme {
        switch self {
            case .one:
                return Theme(name: "Modern",
                             textColor: Color("TextColor"),
                             backgroundColor: Color("Background"),
                             weatherBackground: Color("WeatherBackground"),
                             accentColor: Color("Accent"))
            case .two:
                return Theme(name: "Jungle",
                             textColor: Color("G-TextColor"),
                             backgroundColor: Color("G-Background"),
                             weatherBackground: Color("G-WeatherBackground"),
                             accentColor: Color("G-Accent"))
            case .three:
                return Theme(name: "Charcoal",
                             textColor: Color("B-TextColor"),
                             backgroundColor: Color("B-Background"),
                             weatherBackground: Color("B-WeatherBackground"),
                             accentColor: Color("B-Accent"))
            case .four:
                return Theme(name: "Aqua",
                             textColor: Color("T-TextColor"),
                             backgroundColor: Color("T-Background"),
                             weatherBackground: Color("T-WeatherBackground"),
                             accentColor: Color("T-Accent"))
        }
    }


}
