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
            WPText("Days Name", color: theme.textColor)
            Spacer()
//            TemperatureBar(temperature: 65,
//                           high: 80, low: 50,
//                           weekHigh: 80, weekLow: 40)
            TBar(temperature: 65,
                 weekLow: 40, weekHigh: 80,
                 currentLow: 60, currentHigh: 75)
            Image(systemName: "sun.max.fill")                
            WPText("L:63°", color: theme.textColor)
            WPText("H:80°", color: theme.textColor)
        }.padding()
    }
    
    
    
}


struct HomeViewModel_Previews: PreviewProvider {
    static var previews: some View {
//        HomeView()
        
        let current = 75
        let rangeLow = 50
        let rangeHigh = 90
        let currentLow = 68
        let currentHigh = 82
        
        Background {
            VStack {
                //            TemperatureBar(temperature: 70,
                //                           high: 80, low: 58,
                //                           weekHigh: 80, weekLow: 58)
                
                TempBar(temperature: 75,
                        rangeLow: 58, rangeHigh: 90,
                        currentLow: 70, currentHigh: 80)
                .frame(width: UIScreen.main.bounds.width / 3)
                
                Divider()
                
                TBar(temperature: currentHigh,
                     weekLow: rangeLow, weekHigh: rangeHigh,
                     currentLow: currentLow, currentHigh: currentHigh)
                .frame(width: UIScreen.main.bounds.width / 3)
                
                TBar(temperature: 77,
                     weekLow: rangeLow, weekHigh: rangeHigh,
                     currentLow: currentLow, currentHigh: currentHigh)
                .frame(width: UIScreen.main.bounds.width / 3)
                
                TBar(temperature: current,
                     weekLow: rangeLow, weekHigh: rangeHigh,
                     currentLow: currentLow, currentHigh: currentHigh)
                .frame(width: UIScreen.main.bounds.width / 3)
                
                TBar(temperature: 70,
                     weekLow: rangeLow, weekHigh: rangeHigh,
                     currentLow: currentLow, currentHigh: currentHigh)
                .frame(width: UIScreen.main.bounds.width / 3)
                
                TBar(temperature: currentLow,
                     weekLow: rangeLow, weekHigh: rangeHigh,
                     currentLow: currentLow, currentHigh: currentHigh)
                .frame(width: UIScreen.main.bounds.width / 3)

                Divider()
                
                VStack {
                    
                    Text("Current: \(current)")
                        .padding(5)
                    HStack {
                        VStack {
                            Text("RangeLow: \(rangeLow)")
                            Text("RangeHigh: \(rangeHigh)")
                                .padding(5)
                        }
                        VStack {
                            Text("CurrentLow: \(currentLow)")
                            Text("CurrentHigh: \(currentHigh)")
                                .padding(5)
                        }
                    }
                    
                }
            }
        }
    }
}

struct TemperatureBar: View {
    var temperature: Int // The temperature value
    var high: Int // Highest tempature
    var low: Int // Lowest tempature
    var weekHigh: Int
    var weekLow: Int
    
    var body: some View {
        VStack {
            
            Text("\(temperature)°")
                .font(.headline)
            
            ZStack(alignment: .leading) {
                Capsule()
                    .frame(height: 8)
                    .foregroundColor(.gray)
                
                Capsule()
                    .frame(width: calculateWidth(), height: 8)
                    .foregroundColor(temperatureColor())
                    .offset(x: calculateOffset())
            }
        }
        .padding()
    }
    
    // Helper function to calculate the width of the colored capsule
    private func calculateWidth() -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        let maxWidth = screenWidth / 3 // Adjust as per your layout
        let tempRange = CGFloat(high - low)
        let normalizedTemperature = CGFloat(temperature - low) / tempRange // Normalize the temperature value
        
        return normalizedTemperature * maxWidth
//        return maxWidth / tempRange
    }
    
    // Helper function to calculate the offset of the colored capsule
    private func calculateOffset() -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        let maxWidth = screenWidth / 3 // Adjust as per your layout
        let temperatureRange = CGFloat(low - weekLow) // Range of temperatures (89 - 58)
        let normalizedTemperature = CGFloat(temperature - weekLow) / temperatureRange // Normalize the temperature value
        
        let topCapsuleWidth = calculateWidth()
        let offset = (maxWidth - topCapsuleWidth) * normalizedTemperature
        
        return offset
    }
    
    // Helper function to determine the color based on temperature
    private func temperatureColor() -> Color {
        if temperature < 10 {
            return .blue
        } else if temperature < 20 {
            return .green
        } else if temperature < 30 {
            return .yellow
        } else {
            return .red
        }
    }
}

struct TempBar: View {
    var temperature: Int // The temperature value
    
    
    
    
    let rangeLow: Int // bottom
    let rangeHigh: Int
    
    let currentLow: Int // top
    let currentHigh: Int
    
    var body: some View {
        VStack {
            Text("Today's Temperature")
                .font(.headline)
            
            ZStack(alignment: .leading) {
                Capsule()
                    .frame(height: 8)
                    .foregroundColor(.gray)
                
                Capsule()
                    .frame(width: calculateWidth(), height: 8)
                    .foregroundColor(temperatureColor())
                
                Circle()
                    .frame(width: 12, height: 12)
                    .foregroundColor(.white)
                    .offset(x: calculateOffset())
//                    .position(x: calculateCirclePosition(), y: 4)
            }
            
            Text("\(temperature)°")
                .font(.headline)
        }
        .padding()
    }
    
    // Helper function to calculate the width of the colored capsule
    private func calculateWidth() -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        let maxWidth = screenWidth / 3 // Adjust as per your layout
        
        let normalizedTemperature = CGFloat(temperature - rangeLow) / CGFloat(rangeHigh - rangeLow)
        
        return normalizedTemperature * maxWidth
    }
    
    // Helper function to calculate the offset of the colored capsule
    private func calculateOffset() -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        let maxWidth = screenWidth / 3 // Adjust as per your layout
        let temperatureRange = CGFloat(currentLow - rangeLow) // Range of temperatures (89 - 58)
        let normalizedTemperature = CGFloat(temperature - rangeLow) / temperatureRange // Normalize the temperature value
        
        let topCapsuleWidth = calculateWidth()
        let offset = (maxWidth - topCapsuleWidth) * normalizedTemperature
        
        return offset
    }

    
    // Helper function to calculate the position of the circle
    private func calculateCirclePosition() -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        let maxWidth = screenWidth / 3 // Adjust as per your layout
        
        let normalizedPosition = CGFloat(temperature - rangeLow) / CGFloat(rangeHigh - rangeLow)
        
        return normalizedPosition * maxWidth
    }
    
    // Helper function to determine the color based on temperature
    private func temperatureColor() -> Color {
        if temperature < 60 {
            return .blue
        } else if temperature < 70 {
            return .green
        } else {
            return .red
        }
    }
}


struct TBar: View {
    var temperature: Int // The temperature value
    
    let weekLow: Int // Lowest temperature for the week
    let weekHigh: Int // Highest temperature for the week
    
    let currentLow: Int // Lowest temperature for the current range
    let currentHigh: Int // Highest temperature for the current range
    
    var body: some View {
        VStack {
            ZStack(alignment: .leading) {
                Capsule()
                    .frame(height: 8)
                    .foregroundColor(.gray)
                
                Capsule()
                    .frame(width: calculateWidth(), height: 8)
                    .foregroundColor(temperatureColor())
                    .offset(x: calculateOffset())
//                    .overlay(
                
                Circle()
                    .frame(width: 12, height: 12)
                    .foregroundColor(.white)
                    .offset(x: calculateCirclePosition())
//                )
            }
            
            Text("\(temperature)°")
                .font(.headline)
        }
        .padding()
    }
    
    // Helper function to calculate the width of the colored capsule
    private func calculateWidth() -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        let maxWidth = screenWidth / 3 // Adjust as per your layout
        let tempRange = CGFloat(weekHigh - weekLow)
        
        let normalizedTemperature = CGFloat(temperature - currentLow) / CGFloat(weekHigh - weekLow)
//        let normalizedTemperature = tempRange / CGFloat(currentHigh - currentLow)
        
        
        let y = normalizedTemperature * maxWidth
        let x = y / 3
        return y
    }
    
    // Helper function to calculate the offset of the colored capsule
    private func calculateOffset() -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        let maxWidth = screenWidth / 3 // Adjust as per your layout
        
//        let normalizedPosition = CGFloat(weekLow - currentLow) / CGFloat(weekHigh - weekLow)
        let normalizedPosition = CGFloat(weekLow - currentLow) / CGFloat(currentHigh - currentLow)

        
        let y = -normalizedPosition * maxWidth
        let x = y / 3
        return x
    }
    
    // Helper function to calculate the position of the circle
    private func calculateCirclePosition() -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        let maxWidth = screenWidth / 3 // Adjust as per your layout
        
        let normalizedPosition = CGFloat(temperature - currentLow) / CGFloat(currentHigh - currentLow)
        
        let y =  normalizedPosition * maxWidth
        let x = y / 3
        return x
    }
    
    // Helper function to determine the color based on temperature
    private func temperatureColor() -> Color {
        if temperature < weekLow + ((weekHigh - weekLow) / 3) {
            return .blue
        } else if temperature < weekLow + ((weekHigh - weekLow) / 3 * 2) {
            return .green
        } else {
            return .red
        }
    }
}

