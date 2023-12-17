//
//  TenDayForecastResults.swift
//  Weather Provider
//
//  Created by Matthew Sousa on 5/23/23.
//

import Foundation
import SwiftUI

// MARK: - TenDayForecastResults**
//struct TenDayForecastResults: Codable {
//    var location: Location
//    var current: Current
//    var forecast: Forecast
//}
//
//// MARK: - Current
//struct Current: Codable {
//    var lastUpdatedEpoch: Int
//    var lastUpdated: String
//    var tempC: Double
//    var tempF, isDay: Int
//    var condition: Condition
//    var windMph, windKph: Double
//    var windDegree: Int
//    var windDir: WindDir
//    var pressureMB: Int
//    var pressureIn: Double
//    var precipMm, precipIn, humidity, cloud: Int
//    var feelslikeC: Double
//    var feelslikeF, visKM, visMiles, uv: Int
//    var gustMph: Double
//    var gustKph: Int
//    var airQuality: [String: Double]
//
//    enum CodingKeys: String, CodingKey {
//        case lastUpdatedEpoch = "last_updated_epoch"
//        case lastUpdated = "last_updated"
//        case tempC = "temp_c"
//        case tempF = "temp_f"
//        case isDay = "is_day"
//        case condition
//        case windMph = "wind_mph"
//        case windKph = "wind_kph"
//        case windDegree = "wind_degree"
//        case windDir = "wind_dir"
//        case pressureMB = "pressure_mb"
//        case pressureIn = "pressure_in"
//        case precipMm = "precip_mm"
//        case precipIn = "precip_in"
//        case humidity, cloud
//        case feelslikeC = "feelslike_c"
//        case feelslikeF = "feelslike_f"
//        case visKM = "vis_km"
//        case visMiles = "vis_miles"
//        case uv
//        case gustMph = "gust_mph"
//        case gustKph = "gust_kph"
//        case airQuality = "air_quality"
//    }
//}
//
// MARK: - Condition
struct Condition: Codable {
    var text: String
    var icon: String
    var code: Int

    func image() -> Image {
        
        var conditionImage: ConditionImage = .sun
    
        switch code {
            case 1000:
                conditionImage = .sun
            case 1003:
                conditionImage = .partlyCloudy
            case 1006, 1009:
                conditionImage = .cloudy
            case 1030, 1035, 1147:
                conditionImage = .fog
            case 1063, 1150, 1153, 1180, 1240:
                conditionImage = .cloudyDrizzle
            case 1066, 1117, 1210, 1213, 1216, 1219, 1222, 1225, 1255:
                conditionImage = .cloudySnow
            case 1069, 1204, 1207, 1249, 1252:
                conditionImage = .cloudySleet
            case 1072, 1168, 1171, 1198, 1201, 1237:
                conditionImage = .cloudyHail
            case 1114:
                conditionImage = .windySnow
            case 1183, 1189, 1195, 1243:
                conditionImage = .cloudyRain
            case 1186, 1192, 1246:
                conditionImage = .cloudyHeavyRain
            case 1087:
                conditionImage = .cloudySnowThunder
            default:
                conditionImage = .sun
        }

        return Image(systemName: conditionImage.image)

    }
    
    enum CodingKeys: String, CodingKey {
        case text = "text"
        case icon = "icon"
        case code = "code"
    }
    
    enum ConditionImage: Int,  CaseIterable {
        case sun = 000001
        case partlyCloudy = 000002
        case cloudy = 000003
        case fog = 000004
        case cloudyDrizzle = 000005
        case cloudySnow = 000006
        case cloudySleet = 000007
        case cloudyHail = 000008
        case windySnow = 000009
        case cloudyRain = 000010
        case cloudyHeavyRain = 000011
        case cloudySnowThunder = 000012
        
        var image: String {
            switch self {
                case .sun:
                    return "sun.max.fill"
                case .partlyCloudy:
                    return "cloud.sun.fill"
                case .cloudy:
                    return "cloud.fill"
                case .fog:
                    return "cloud.fog.fill"
                case .cloudyDrizzle:
                    return "cloud.drizzle.fill"
                case .cloudySnow:
                    return "cloud.snow.fill"
                case .cloudySleet:
                    return "cloud.sleet.fill"
                case .cloudyHail:
                    return "cloud.hail.fill"
                case .windySnow:
                    return "wind.snow"
                case .cloudyRain:
                    return "cloud.rain.fill"
                case .cloudyHeavyRain:
                    return "cloud.heavyrain.fill"
                case .cloudySnowThunder:
                    return "cloud.bolt.rain.fill"
            }
        }
        
        
        
        
        
    }
    
}

enum ConditionDescription: String, Codable {
    case clear = "Clear"
    case cloudy = "Cloudy"
    case lightRainShower = "Light rain shower"
    case overcast = "Overcast"
    case partlyCloudy = "Partly cloudy"
    case patchyRainPossible = "Patchy rain possible"
    case sunny = "Sunny"
}

enum WindDir: String, Codable {
    case s = "S"
    case se = "SE"
    case sse = "SSE"
    case ssw = "SSW"
    case sw = "SW"
    case wsw = "WSW"
}

// MARK: - Forecast
struct Forecast: Codable, Equatable {
    var forecastday: [Forecastday]
}

// MARK: - Forecastday
struct Forecastday: Codable, Equatable, Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(date)
    }
    
    static func == (lhs: Forecastday, rhs: Forecastday) -> Bool {
        return lhs.date == rhs.date &&
            lhs.dateEpoch == rhs.dateEpoch
        }
    
    
    var date: String
    var dateEpoch: Int
    var day: Day
    var astro: Astro
    var hour: [Hour]

    enum CodingKeys: String, CodingKey {
        case date
        case dateEpoch = "date_epoch"
        case day, astro, hour
    }
}

// MARK: - Astro
struct Astro: Codable {
    var sunrise, sunset, moonrise, moonset, moonPhase: String
    var isMoonUp, isSunUp, moonIllumination: Int

    enum CodingKeys: String, CodingKey {
        case sunrise, sunset, moonrise, moonset
        case moonPhase = "moon_phase"
        case moonIllumination = "moon_illumination"
        case isMoonUp = "is_moon_up"
        case isSunUp = "is_sun_up"
    }
}

// MARK: - Day
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

// MARK: - Hour
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
    var visKM, visMiles: Int
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

//// MARK: - Location
//struct Location: Codable {
//    var name, region, country: String
//    var lat, lon: Double
//    var tzID: String
//    var localtimeEpoch: Int
//    var localtime: String
//
//    enum CodingKeys: String, CodingKey {
//        case name, region, country, lat, lon
//        case tzID = "tz_id"
//        case localtimeEpoch = "localtime_epoch"
//        case localtime
//    }
//}


// ----------------------------------------------
struct Location: Codable, Equatable, CustomStringConvertible {
    let name: String
    let region: String
    let country: String
    let latitude: Double
    let longitude: Double
    let timezoneID: String
    let localTimeEpoch: Int
    let localTime: String
    
    init(name: String, region: String, country: String, latitude: Double, longitude: Double, timezoneID: String = "", localTimeEpoch: Int = 0, localTime: String = "") {
        self.name = name
        self.region = region
        self.country = country
        self.latitude = latitude
        self.longitude = longitude
        self.timezoneID = timezoneID
        self.localTimeEpoch = localTimeEpoch
        self.localTime = localTime
    }
    
    enum CodingKeys: String, CodingKey {
        case name, region, country
        case latitude = "lat"
        case longitude = "lon"
        case timezoneID = "tz_id"
        case localTimeEpoch = "localtime_epoch"
        case localTime = "localtime"
    }
    
    var description: String {
        return "\(name), \(country), \n(\(longitude),\(latitude))"
    }
    
    static func ==(lhs: Location, rhs: Location) -> Bool {
        return lhs.name == rhs.name && lhs.region == rhs.region && lhs.country == rhs.country && lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude && lhs.timezoneID == rhs.timezoneID && lhs.localTimeEpoch == rhs.localTimeEpoch && lhs.localTime == rhs.localTime
    }
}

struct WeatherCondition: Codable {
    let text: String
    let icon: String
    let code: Int
}

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

struct AirQuality: Codable {
    let carbonMonoxide: Double
    let nitrogenDioxide: Double
    let ozone: Double
    let sulfurDioxide: Double
    let pm2_5: Double
    let pm10: Double
    let usEPAIndex: Int
    let gbDefraIndex: Int
    
    enum CodingKeys: String, CodingKey {
        case carbonMonoxide = "co"
        case nitrogenDioxide = "no2"
        case ozone = "o3"
        case sulfurDioxide = "so2"
        case pm2_5 = "pm2_5"
        case pm10
        case usEPAIndex = "us-epa-index"
        case gbDefraIndex = "gb-defra-index"
    }
}

struct AutoCompleteLocation: Codable, Equatable {
    let id: Double
    let name: String
    let region: String
    let country: String
    let latitude: Double
    let longitude: Double
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case region = "region"
        case country = "country"
        case latitude = "lat"
        case longitude = "lon"
        case url = "url"
    }
    
    func asLocation() -> Location {
        return Location(name: self.name, region: self.region, country: self.country, latitude: self.latitude, longitude: self.longitude)
    }
}

//struct HourlyForecast: Codable {
//    let timeEpoch: Int
//    let time: String
//    let temperatureCelsius: Double
//    let temperatureFahrenheit: Double
//    let isDay: Int
//    let condition: WeatherCondition
//    let windMph: Double
//    let windKph: Double
//    let windDegree: Int
//    let windDirection: String
//    let pressureMb: Double
//    let pressureIn: Double
//    let precipitationMm: Double
//    let precipitationIn: Double
//    let humidity: Int
//    let cloudCover: Int
//    let feelsLikeCelsius: Double
//    let feelsLikeFahrenheit: Double
//    let windChillCelsius: Double
//    let windChillFahrenheit: Double
//    let heatIndexCelsius: Double
//    let heatIndexFahrenheit: Double
//    let dewPointCelsius: Double
//    let dewPointFahrenheit: Double
//    let willItRain: Int
//    let chanceOfRain: Int
//    let willItSnow: Int
//    let chanceOfSnow: Int
//    let visibilityKm: Double
//    let visibilityMiles: Double
//    let gustMph: Double
//    let gustKph: Double
//    let uvIndex: Double
//    
//    enum CodingKeys: String, CodingKey {
//        case timeEpoch = "time_epoch"
//        case time
//        case temperatureCelsius = "temp_c"
//        case temperatureFahrenheit = "temp_f"
//        case isDay = "is_day"
//        case condition
//        case windMph = "wind_mph"
//        case windKph = "wind_kph"
//        case windDegree = "wind_degree"
//        case windDirection = "wind_dir"
//        case pressureMb = "pressure_mb"
//        case pressureIn = "pressure_in"
//        case precipitationMm = "precip_mm"
//        case precipitationIn = "precip_in"
//        case humidity
//        case cloudCover = "cloud"
//        case feelsLikeCelsius = "feelslike_c"
//        case feelsLikeFahrenheit = "feelslike_f"
//        case windChillCelsius = "windchill_c"
//        case windChillFahrenheit = "windchill_f"
//        case heatIndexCelsius = "heatindex_c"
//        case heatIndexFahrenheit = "heatindex_f"
//        case dewPointCelsius = "dewpoint_c"
//        case dewPointFahrenheit = "dewpoint_f"
//        case willItRain = "will_it_rain"
//        case chanceOfRain = "chance_of_rain"
//        case willItSnow = "will_it_snow"
//        case chanceOfSnow = "chance_of_snow"
//        case visibilityKm = "vis_km"
//        case visibilityMiles = "vis_miles"
//        case gustMph = "gust_mph"
//        case gustKph = "gust_kph"
//        case uvIndex = "uv"
//    }
//}

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
    let condition: WeatherCondition
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

struct WeatherForecast: Codable {
    let forecastDays: [DayForecast]?
//    let forecastDays: [String: Any]
    
    enum CodingKeys: String, CodingKey {
        case forecastDays = "forecastday"
    }
}

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
