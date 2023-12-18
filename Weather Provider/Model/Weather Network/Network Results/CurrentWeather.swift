//
//  CurrentWeather.swift
//  Weather Provider
//
//  Created by Matthew Sousa on 12/18/23.
//

import Foundation

struct CurrentWeather: Codable, Equatable {
    static func == (lhs: CurrentWeather, rhs: CurrentWeather) -> Bool {
        return lhs.lastUpdatedEpoch == rhs.lastUpdatedEpoch &&
        lhs.lastUpdated == rhs.lastUpdated &&
        lhs.temperatureCelsius == rhs.temperatureCelsius &&
        lhs.temperatureFahrenheit == rhs.temperatureFahrenheit &&
        lhs.isDay == rhs.isDay &&
        lhs.windMph == rhs.windMph &&
        lhs.windKph == rhs.windKph &&
        lhs.windDegree == rhs.windDegree &&
        lhs.pressureIn == rhs.pressureIn
    }
    
    let lastUpdatedEpoch: Int
    let lastUpdated: String
    let temperatureCelsius: Double
    let temperatureFahrenheit: Double
    let isDay: Int
    let condition: WeatherCondition
    let windMph: Double
    let windKph: Double
    let windDegree: Int
    let windDirection: String
    let pressureMb: Double
    let pressureIn: Double
    let precipitationMm: Double
    let precipitationIn: Double
    let humidity: Int
    let cloudCover: Int
    let feelsLikeCelsius: Double
    let feelsLikeFahrenheit: Double
    let visibilityKm: Double
    let visibilityMiles: Double
    let uvIndex: Double
    let gustMph: Double
    let gustKph: Double
    let airQuality: AirQuality?
    
    enum CodingKeys: String, CodingKey {
        case lastUpdatedEpoch = "last_updated_epoch"
        case lastUpdated = "last_updated"
        case temperatureCelsius = "temp_c"
        case temperatureFahrenheit = "temp_f"
        case isDay = "is_day"
        case condition
        case windMph = "wind_mph"
        case windKph = "wind_kph"
        case windDegree = "wind_degree"
        case windDirection = "wind_dir"
        case pressureMb = "pressure_mb"
        case pressureIn = "pressure_in"
        case precipitationMm = "precip_mm"
        case precipitationIn = "precip_in"
        case humidity
        case cloudCover = "cloud"
        case feelsLikeCelsius = "feelslike_c"
        case feelsLikeFahrenheit = "feelslike_f"
        case visibilityKm = "vis_km"
        case visibilityMiles = "vis_miles"
        case uvIndex = "uv"
        case gustMph = "gust_mph"
        case gustKph = "gust_kph"
        case airQuality
    }
}
