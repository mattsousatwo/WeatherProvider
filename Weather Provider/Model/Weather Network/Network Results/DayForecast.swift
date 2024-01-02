//
//  DayForecast.swift
//  Weather Provider
//
//  Created by Matthew Sousa on 12/18/23.
//

import Foundation

struct DayForecast: Codable {
    let date: String
    let dateEpoch: Int
    let maxTemperatureCelsius: Double
    let maxTemperatureFahrenheit: Double
    let minTemperatureCelsius: Double
    let minTemperatureFahrenheit: Double
    let averageTemperatureCelsius: Double
    let averageTemperatureFahrenheit: Double
    let maxWindMph: Double
    let maxWindKph: Double
    let totalPrecipitationMm: Double
    let totalPrecipitationIn: Double
    let totalSnowCm: Double
    let averageVisibilityKm: Float
    let averageVisibilityMiles: Float
    let averageHumidity: Int
    let willItRain: Int
    let chanceOfRain: Int
    let willItSnow: Int
    let chanceOfSnow: Int
    let condition: Condition
    let uvIndex: Double
    
    enum CodingKeys: String, CodingKey {
        case date
        case dateEpoch = "date_epoch"
        case maxTemperatureCelsius = "maxtemp_c"
        case maxTemperatureFahrenheit = "maxtemp_f"
        case minTemperatureCelsius = "mintemp_c"
        case minTemperatureFahrenheit = "mintemp_f"
        case averageTemperatureCelsius = "avgtemp_c"
        case averageTemperatureFahrenheit = "avgtemp_f"
        case maxWindMph = "maxwind_mph"
        case maxWindKph = "maxwind_kph"
        case totalPrecipitationMm = "totalprecip_mm"
        case totalPrecipitationIn = "totalprecip_in"
        case totalSnowCm = "totalsnow_cm"
        case averageVisibilityKm = "avgvis_km"
        case averageVisibilityMiles = "avgvis_miles"
        case averageHumidity = "avghumidity"
        case willItRain = "daily_will_it_rain"
        case chanceOfRain = "daily_chance_of_rain"
        case willItSnow = "daily_will_it_snow"
        case chanceOfSnow = "daily_chance_of_snow"
        case condition
        case uvIndex = "uv"
    }
}
