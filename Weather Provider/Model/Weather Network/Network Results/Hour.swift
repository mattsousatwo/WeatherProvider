//
//  Hour.swift
//  Weather Provider
//
//  Created by Matthew Sousa on 12/18/23.
//

import Foundation

struct Hour: Codable {
    var timeEpoch: Int
    var time: String
    var tempC, tempF: Double
    var isDay: Int
    var condition: Condition
    var windMph, windKph: Double
    var windDegree: Int
    var windDir: String
    var pressureMB: Int
    var pressureIn, precipMm, precipIn: Double
    var humidity, cloud: Int
    var feelslikeC, feelslikeF, windchillC, windchillF: Double
    var heatindexC, heatindexF, dewpointC, dewpointF: Double
    var willItRain, chanceOfRain, willItSnow, chanceOfSnow: Int
    var visKM, visMiles: Double
    var gustMph, gustKph: Double
    var uv: Int
    
    enum CodingKeys: String, CodingKey {
        case timeEpoch = "time_epoch"
        case time
        case tempC = "temp_c"
        case tempF = "temp_f"
        case isDay = "is_day"
        case condition
        case windMph = "wind_mph"
        case windKph = "wind_kph"
        case windDegree = "wind_degree"
        case windDir = "wind_dir"
        case pressureMB = "pressure_mb"
        case pressureIn = "pressure_in"
        case precipMm = "precip_mm"
        case precipIn = "precip_in"
        case humidity, cloud
        case feelslikeC = "feelslike_c"
        case feelslikeF = "feelslike_f"
        case windchillC = "windchill_c"
        case windchillF = "windchill_f"
        case heatindexC = "heatindex_c"
        case heatindexF = "heatindex_f"
        case dewpointC = "dewpoint_c"
        case dewpointF = "dewpoint_f"
        case willItRain = "will_it_rain"
        case chanceOfRain = "chance_of_rain"
        case willItSnow = "will_it_snow"
        case chanceOfSnow = "chance_of_snow"
        case visKM = "vis_km"
        case visMiles = "vis_miles"
        case gustMph = "gust_mph"
        case gustKph = "gust_kph"
        case uv
    }
}
