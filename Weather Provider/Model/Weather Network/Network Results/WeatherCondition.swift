//
//  WeatherCondition.swift
//  Weather Provider
//
//  Created by Matthew Sousa on 12/18/23.
//

import Foundation

struct WeatherCondition: Codable {
    let text: String
    let icon: String
    let code: Int
}
