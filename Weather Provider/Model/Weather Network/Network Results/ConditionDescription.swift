//
//  ConditionDescription.swift
//  Weather Provider
//
//  Created by Matthew Sousa on 12/18/23.
//

import Foundation

enum ConditionDescription: String, Codable {
    case clear = "Clear"
    case cloudy = "Cloudy"
    case lightRainShower = "Light rain shower"
    case overcast = "Overcast"
    case partlyCloudy = "Partly cloudy"
    case patchyRainPossible = "Patchy rain possible"
    case sunny = "Sunny"
}
