//
//  TemperatureBar.swift
//  Weather Provider
//
//  Created by Matthew Sousa on 6/10/23.
//

import SwiftUI

struct TemperatureBar: View {
    
    @EnvironmentObject var themeManager: ThemeManager
    
    var day: Forecastday
    
    var currentTemp: Degree?
    
    /// Minimum Temp for temperture range
    var minimumTemp: Degree
    
    /// Maximum Temp for temperture range
    var maximumTemp: Degree
    
    
    /// Minimum Temperture for the current day
    var currentMinimumTemp: Degree {
        return Degree(day.day.mintempF)
    }
    /// Maxium Temperture for the current day
    var currentMaximumTemp: Degree {
        return Degree(day.day.maxtempF)
    }
    
    /// The current days name
    var daysName: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "y-M-d"
        if let date = formatter.date(from: day.date) {
            formatter.dateFormat = "EEEE"
            return formatter.string(from: date)
        } else {
            return "Day"
        }
    }
    
    var offset: CGFloat {
        let offset = (currentMinimumTemp.asCGFloat - minimumTemp.asCGFloat) / (maximumTemp.asCGFloat - minimumTemp.asCGFloat)
        return offset
    }
    
    var capsuleWidth: CGFloat {
        let max = (currentMaximumTemp.asCGFloat - minimumTemp.asCGFloat) / (maximumTemp.asCGFloat - minimumTemp.asCGFloat)
        let min = (currentMinimumTemp.asCGFloat - minimumTemp.asCGFloat) / (maximumTemp.asCGFloat - minimumTemp.asCGFloat)
        return max - min
    }

    var body: some View {
        HStack {
            Spacer() 
            dayLabel(daysName, themeManager.currentTheme)
            Spacer()
            weatherImage("sun.max.fill")
            Spacer()
            minimumTempView(currentMinimumTemp)
            tempertureCapsule()
            maximumTempView(currentMaximumTemp)
            Spacer()
        }
        .padding(6)
    }
}


extension TemperatureBar {
    
    func dayLabel(_ day: String, _ theme: Theme) -> some View {
        WPText(day, color: theme.textColor)
    }
    
    func weatherImage(_ name: String) -> some View {
        day.day.condition.image()
            .renderingMode(.original)
            .foregroundColor(.white)
    }
    
    func minimumTempView(_ temp: Degree) -> some View {
        WPText("\(temp.asString)", color: themeManager.currentTheme.textColor)
            .multilineTextAlignment(.trailing)
            .frame(width: 34, alignment: .trailing)
    }
    
    func maximumTempView(_ temp: Degree) -> some View {
        WPText("\(temp.asString)", color: themeManager.currentTheme.textColor)
            .fontWeight(.semibold)
            .multilineTextAlignment(.leading)
            .frame(width: 34, alignment: .leading)
    }
    
    func backgroundCapsule() -> some View {
        Capsule()
            .fill(.quaternary)
            .frame(height: 10)
    }
    
    func tempCapsule(_ proxy: GeometryProxy) -> some View {
        TemperatureCapsule(currentTemp: currentTemp,
                           minimumTemp: minimumTemp, maximumTemp: maximumTemp,
                           currentMinimumTemp: currentMinimumTemp, currentMaximumTemp: currentMaximumTemp)
        .frame(width: capsuleWidth * proxy.size.width)
        .offset(x: proxy.size.width * offset)

    }

    func tempertureCapsule() -> some View {
        GeometryReader { proxy in
            ZStack(alignment: .leading) {
                backgroundCapsule()
                tempCapsule(proxy)
            }
        }
        .frame(width: 100, height: 10)
    }

}
//
//struct TemperatureBar_Previews: PreviewProvider {
//    static var previews: some View {
//        TemperatureBar(day: Forecastday(date: "", dateEpoch: 0, day: Day(), astro: Astro(), hour: []),
//                       minimumTemp: Degree(22), maximumTemp: Degree(40))
//    }
//}
//















