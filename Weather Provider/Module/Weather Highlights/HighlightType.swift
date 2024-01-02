//
//  HighlightType.swift
//  Weather Provider
//
//  Created by Matthew Sousa on 12/30/23.
//

import Foundation
import SwiftUI

enum HighlightType: Equatable {
    case airQuality(weather: WeatherInfo?)
    case sun(weather: WeatherInfo?)
    case moon(weather: WeatherInfo?)
    case percipitation(weather: WeatherInfo?)
    case uv(weather: WeatherInfo?)
    case wind(weather: WeatherInfo?)
    case humidity(weather: WeatherInfo?)
    case feelsLike(weather: WeatherInfo?)
    
    
    var image: Image {
        switch self {
            case .airQuality(let weather):
                var imageName: String = "aqi.low"
                if let epaIndex = weather?.currentWeather.airQuality?.usEPAIndex {
                    switch epaIndex {
                        case 1...2:
                            imageName = "aqi.low"
                        case 3...4:
                            imageName = "aqi.medium"
                        case 5...6:
                            imageName = "aqi.high"
                        default:
                            imageName = "aqi.low"
                    }
                }
                return Image(systemName: imageName)
            case .sun(let weather):
                if weather?.forecast.forecastday.first?.astro.isSunUp == 1 {
                    return Image(systemName: "sunset.fill")
                } else {
                    return Image(systemName: "sunrise.fill")
                }
            case .moon(let weather):
                if weather?.forecast.forecastday.first?.astro.isMoonUp == 1 {
                    return Image(systemName: "moonset.fill")
                } else {
                    return Image(systemName: "moonrise.fill")
                }
            case .percipitation(let weather):
                if let weather = weather {
                    if weather.forecast.forecastday.first?.day.dailyWillItRain == 1 {
                        return Image(systemName: "cloud.rain.fill")
                    } else {
                        if weather.forecast.forecastday.first?.day.dailyWillItSnow == 1 {
                            return Image(systemName: "cloud.snow.fill")
                        } else {
                            return weather.currentWeather.condition.image()
                        }
                    }
                }
                return Image(systemName: "cloud.rain.fill")
            case .uv:
                return Image(systemName: "sun.max.trianglebadge.exclamationmark.fill")
            case .wind:
                return Image(systemName: "wind")
            case .humidity:
                return Image(systemName: "humidity.fill")
            case .feelsLike:
                return Image(systemName: "thermometer.medium")
        }
    }
    
    var imageWidth: CGFloat {
        switch self {
            case .airQuality:
                return 40
            case .sun:
                return 45
            case .moon:
                return 40
            case .percipitation:
                return 40
            case .uv:
                return 40
            case .wind:
                return 40
            case .humidity:
                return 40
            case .feelsLike:
                return 28
        }
    }
    
    var imageHeight: CGFloat {
        switch self {
            case .airQuality:
                return 40
            case .sun:
                return 40
            case .moon:
                return 40
            case .percipitation:
                return 40
            case .uv:
                return 40
            case .wind:
                return 40
            case .humidity:
                return 40
            case .feelsLike:
                return 40 
        }
    }
    
    var title: String {
        switch self {
            case .airQuality:
                return "Air Quality"
            case .sun(let weather):
                if weather?.forecast.forecastday.first?.astro.isSunUp == 1 {
                    return "Sunset"
                } else {
                    return "Sunrise"
                }
            case .moon(let weather):
                if weather?.forecast.forecastday.first?.astro.isMoonUp == 1 {
                    return "Moonset"
                } else {
                    return "Moonrise"
                }
            case .percipitation(let weather):
                var titleString: String = "Clear"
                if weather?.forecast.forecastday.first?.day.dailyWillItRain == 1 {
                    titleString = "Rain"
                }
                if weather?.forecast.forecastday.first?.day.dailyWillItSnow == 1 {
                    titleString = "Snow"
                }
                return titleString
            case .uv:
                return "UV"
            case .wind:
                return "Wind"
            case .humidity:
                return "Humidity"
            case .feelsLike:
                return "Feels Like"
        }
    }
    
    var id: Int {
        switch self {
            case .airQuality(_):
                return 1
            case .sun(_):
                return 2
            case .moon(_):
                return 3
            case .percipitation(_):
                return 4
            case .uv(_):
                return 5
            case .wind(_):
                return 6
            case .humidity(_):
                return 7
            case .feelsLike(_):
                return 8
        }
    }
    
    
    var detail: String {
        switch self {
            case .airQuality(let weather):
                if let epaIndex = weather?.currentWeather.airQuality?.usEPAIndex {
                    switch epaIndex {
                        case 1:
                            return "Good"
                        case 2:
                            return "Moderate"
                        case 3...4:
                            return "Unhealthy"
                        case 5:
                            return "Very Unhealthy"
                        case 6:
                            return "Hazardous"
                        default:
                            return "Good"
                    }
                }
                return "0"
            case .sun(let weather):
                var value: String = "sun"
                if weather?.forecast.forecastday.first?.astro.isSunUp == 1 {
                    // sunset
                    value = weather?.forecast.forecastday.first?.astro.sunset ?? "nil"
                } else {
                    // sunrise
                    value = weather?.forecast.forecastday.first?.astro.sunrise ?? "nil"
                }
                return value
            case .moon(let weather):
                var value: String = "moon"
                if weather?.forecast.forecastday.first?.astro.isMoonUp == 1 {
                    // moonset
                    value = weather?.forecast.forecastday.first?.astro.moonset ?? "nil"
                } else {
                    // moonrise
                    value = weather?.forecast.forecastday.first?.astro.moonrise ?? "nil"
                }
                return value
            case .percipitation(let weather):
                var titleString: String = "Clear"
                if weather?.forecast.forecastday.first?.day.dailyWillItRain == 1 {
                    titleString = "\(weather?.forecast.forecastday.first?.day.totalprecipIn ?? 0.0)" + " in."
                }
                if weather?.forecast.forecastday.first?.day.dailyWillItSnow == 1 {
                    titleString = "\(weather?.forecast.forecastday.first?.day.dailyChanceOfSnow ?? 0)"
                }
                return titleString
            case .uv(let weather):
                if let index = weather?.currentWeather.uvIndex {
                    return "UV Index: \(index)"
                }
                return "UV Index: 0"
            case .wind(let weather):
                if let wind = weather?.currentWeather.windMph,
                   let direction = weather?.currentWeather.windDirection {
                    return "\(wind) MPH\n\(direction)"
                }
                return "0 MPH"
            case .humidity(let weather):
                if let humidity = weather?.forecast.forecastday.first?.day.avghumidity {
                    return "\(humidity) %"
                }
                return "0 %"
            case .feelsLike(let weather):
                if let feelsLike = weather?.currentWeather.feelsLikeFahrenheit {
                    return "\(Degree(feelsLike).asString)"
                }
                return "Feels Like: "
        }
    }
    
    
    }
