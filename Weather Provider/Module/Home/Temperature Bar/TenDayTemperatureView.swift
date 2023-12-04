//
//  TenDayTemperatureView.swift
//  Weather Provider
//
//  Created by Matthew Sousa on 6/11/23.
//

import SwiftUI

struct TenDayTemperatureView: View {
    
    let weatherInfo: WeatherInfo?
    
    var tempRange: (low: Degree, high: Degree) {
        return calculateTempRange(weatherInfo)
    }
    
    var body: some View {
        if let weatherInfo = weatherInfo {
            ForEach(weatherInfo.forecast.forecastday, id: \.self) { forecastDay in
                TemperatureBar(day: forecastDay, minimumTemp: tempRange.low, maximumTemp: tempRange.high)
                    .onAppear {
                        print("\(forecastDay.date)")
                    }
            }
        } else {
            ProgressView()
        }
    }
    
    func calculateTempRange(_ weatherInfo: WeatherInfo?) -> (low: Degree, high: Degree) {
        var minTemp = 0.0
        var maxTemp = 0.0
        if let weatherInfo = weatherInfo {
            for forecastDay in weatherInfo.forecast.forecastday {
                if forecastDay.day.mintempF < minTemp {
                    minTemp = forecastDay.day.mintempF
                }
                
                if forecastDay.day.maxtempF > maxTemp {
                    maxTemp = forecastDay.day.maxtempF
                }
            }
        }
        return (low: Degree(minTemp), high: Degree(maxTemp))
    }
    
}

//struct TenDayTemperatureView_Previews: PreviewProvider {
//    static var previews: some View {
//        TenDayTemperatureView()
//    }
//}
