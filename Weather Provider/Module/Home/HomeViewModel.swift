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
            VStack {
                mainWeatherDisplay(theme)
                hourlyWeatherHStack(theme)
                Spacer()
                
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
            
            WPOTitle("72", color: theme.textColor)
            WPText("Condition", color: theme.textColor)
            WPText("H:75 L:63", color: theme.textColor)
        }
    }
    
    func weatherScroll(_ theme: Theme) -> some View {
        return HStack {
            
            
            
        }
    }
    
    func hourlyWeatherHStack(_ theme: Theme) -> some View {
        
        let times: [(time: String, temp: String)] = [("12PM", "58"),
                                                     ("1PM", "58"),
                                                     ("2PM", "60"),
                                                     ("3PM", "63"),
                                                     ("4PM", "63"),
                                                     ("5PM", "63")]
        
        return ScrollView(.horizontal) {
            HStack {
                ForEach(0..<times.count, id: \.self) { time in
                    hourlyForecast(time: times[time].time,
                                   temp: times[time].temp,
                                   theme: theme)
                }
                .padding(.horizontal, 5)
            }
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
            Text(temp + "°")
                .fontDesign(.rounded)
                .foregroundColor(theme.textColor)
                .padding(.vertical, 5)
            
        }
        
        
    }
}

struct HomeViewModel_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

