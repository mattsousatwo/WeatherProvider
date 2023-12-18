//
//  WeatherForecast.swift
//  Weather Provider
//
//  Created by Matthew Sousa on 12/18/23.
//

import Foundation

struct WeatherForecast: Codable {
    let forecastDays: [DayForecast]?
    
    enum CodingKeys: String, CodingKey {
        case forecastDays = "forecastday"
    }
}
