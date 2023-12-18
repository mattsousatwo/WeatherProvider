//
//  WeatherInfo.swift
//  Weather Provider
//
//  Created by Matthew Sousa on 12/18/23.
//

import Foundation

struct WeatherInfo: Codable, Equatable {
    static func == (lhs: WeatherInfo, rhs: WeatherInfo) -> Bool {
        return lhs.location == rhs.location &&
        lhs.currentWeather == rhs.currentWeather &&
        lhs.forecast == rhs.forecast
    }
    
    let location: Location
    let currentWeather: CurrentWeather
    let forecast: Forecast
    
    enum CodingKeys: String, CodingKey {
        case location
        case currentWeather = "current"
        case forecast
    }
}
