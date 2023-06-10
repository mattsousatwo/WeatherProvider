//
//  HomeViewModel.swift
//  Weather Provider
//
//  Created by Matthew Sousa on 5/18/23.
//

import Foundation
import SwiftUI

/// Struct Containing all the views for the Home Module 
struct HomeViewModel: WPViewModel {
    func mainBody(_ theme: Theme) -> some View {
        viewStructure(theme)
    }
    
    internal func viewStructure(_ theme: Theme) -> some View  {
        Background(theme) {
            ScrollView(.vertical) {
                VStack {
                    mainWeatherDisplay(theme)
                    hourlyWeatherHStack(theme)
                    dailyForecast(theme)
                    Spacer()
                }
            }
        }
    }
}


extension HomeViewModel {
    
    func mainWeatherDisplay(_ theme: Theme) -> some View {
        return VStack {
            WPOTitle("City Name", color: theme.textColor)
            
            Image(systemName: "sun.max.fill")
                .resizable()
                .frame(width: 35, height: 35)
                .foregroundColor(.yellow)
                .padding(.vertical, 5)
            
            WPOTitle("72°", color: theme.textColor)
            WPText("Condition", color: theme.textColor)
            WPText("L:63° H:75°", color: theme.textColor)
        }
    }
    
//    func weatherScroll(_ theme: Theme) -> some View {
//        return HStack {
//
//
//
//        }
//    }
//
    func hourlyWeatherHStack(_ theme: Theme) -> some View {

        let times: [(time: String, temp: Degree)] = [("12PM", Degree(58)),
                                                     ("1PM", Degree(60)),
                                                     ("2PM", Degree(60)),
                                                     ("3PM", Degree(63)),
                                                     ("4PM", Degree(63)),
                                                     ("5PM", Degree(63))]
        
        return ScrollView(.horizontal) {
            HStack {
                ForEach(0..<times.count, id: \.self) { time in
                    hourlyForecast(time: times[time].time,
                                   temp: times[time].temp.asString,
                                   theme: theme)
                }
                .padding(.horizontal, 5)
            }
            .padding(.horizontal, 10)
        }
    }
    
    
    func hourlyForecast(time: String, temp: String, theme: Theme) -> some View {
        return VStack {
            Text(time)
                .fontDesign(.rounded)
                .foregroundColor(theme.textColor)
            Image(systemName: "sun.max.fill")
                .resizable()
                .frame(width: 25, height: 25)
                .foregroundColor(.yellow)
                .padding(.vertical, 5)
            Text(temp)
                .fontDesign(.rounded)
                .foregroundColor(theme.textColor)
                .padding(.vertical, 5)
            
        }
        
        
    }
}

extension HomeViewModel {
    
    func dailyForecast(_ theme: Theme) -> some View {
        return VStack {
            ForEach(0..<10) { _ in
                Divider()
                dayForecast(theme)
            }
        }
    }
    
    func dayForecast(_ theme: Theme) -> some View {
        return HStack {
//            WPText("Days Name", color: theme.textColor)
//            Spacer()
//            Image(systemName: "sun.max.fill")
//            Spacer()
            
//            TemperatureBar(temperature: 65,
//                           high: 80, low: 50,
//                           weekHigh: 80, weekLow: 40)
            
//            TBar(temperature: 74,
//                 weekLow: 55, weekHigh: 78,
//                 currentLow: Degree(60), currentHigh: Degree(74),
//                 theme: theme)
            GuageRow(value: 74, minimumValue: 55, maximumValue: 78,
                      minimumTackValue: 60, maximumTrackValue: 74)
            
        }
        .padding(.horizontal, 10)
    }
    
    
    
}


//struct HomeViewModel_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}
