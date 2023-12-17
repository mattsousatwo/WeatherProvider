//
//  TemporaryWeatherDisplay.swift
//  Weather Provider
//
//  Created by Matthew Sousa on 12/16/23.
//

import SwiftUI

struct TemporaryWeatherDisplay: View {
    
    var weather: WeatherInfo?
    let theme: Theme
        
    var body: some View {
        VStack(alignment: .center) {
            WPOTitle(weather?.location.name ?? "placeholder-copy-title", color: theme.textColor)
            WPText(weather?.location.localTime ?? "placeholder-copy-localeTile",
                   theme)
                .fontDesign(.rounded)
            WPText("\(weather?.currentWeather.condition.text ?? "placeholder-copy-condition")", theme)
                .padding(.bottom, 2)
            
            if let currentDay = weather?.forecast.forecastday.first?.day {
                currentDay.condition.image()
                    .resizable()
                    .renderingMode(.original)
                    .foregroundColor(.white)
                    .frame(width: 25, height: 25)
                    .padding(.vertical, 5)
            }
            
            WPText("\(Degree(weather?.currentWeather.temperatureFahrenheit ?? 0.0).asString)", theme)
                .fontDesign(.rounded)
                .padding(.vertical, 2)
            
            WPText("Feels like: \(Degree(weather?.currentWeather.feelsLikeFahrenheit ?? 0.0).asString)", theme)
        }
        .padding()
        .background(theme.weatherBackground)
        .cornerRadius(12)
        .redacted(reason: weather == nil ? .placeholder : [])
    }
}

//
//
//#Preview {
//    TemporaryWeatherDisplay(weather: <#T##WeatherInfo#>)
//}
