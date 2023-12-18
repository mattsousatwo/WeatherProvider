//
//  Day.swift
//  Weather Provider
//
//  Created by Matthew Sousa on 12/18/23.
//

import Foundation

struct Day: Codable {
    var maxtempC, maxtempF, mintempC, mintempF: Double
    var avgtempC, avgtempF, maxwindMph, maxwindKph: Double
    var totalprecipMm, totalprecipIn: Double
    var totalsnowCM, avgvisKM, avgvisMiles, avghumidity: Double
    var dailyWillItRain, dailyChanceOfRain, dailyWillItSnow, dailyChanceOfSnow: Int
    var condition: Condition
    var uv: Int
    
    enum CodingKeys: String, CodingKey {
        case maxtempC = "maxtemp_c"
        case maxtempF = "maxtemp_f"
        case mintempC = "mintemp_c"
        case mintempF = "mintemp_f"
        case avgtempC = "avgtemp_c"
        case avgtempF = "avgtemp_f"
        case maxwindMph = "maxwind_mph"
        case maxwindKph = "maxwind_kph"
        case totalprecipMm = "totalprecip_mm"
        case totalprecipIn = "totalprecip_in"
        case totalsnowCM = "totalsnow_cm"
        case avgvisKM = "avgvis_km"
        case avgvisMiles = "avgvis_miles"
        case avghumidity
        case dailyWillItRain = "daily_will_it_rain"
        case dailyChanceOfRain = "daily_chance_of_rain"
        case dailyWillItSnow = "daily_will_it_snow"
        case dailyChanceOfSnow = "daily_chance_of_snow"
        case condition, uv
    }
}
