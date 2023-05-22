//
//  OnboardingWeatherDisplayView.swift
//  Weather Provider
//
//  Created by Matthew Sousa on 5/22/23.
//

import SwiftUI

/// View to display an example of what the weather display will look like under different themes
struct OnboardingWeatherDisplayView: View {
    
    @Binding var theme: Theme
    
    let viewModel = OnboardingWeatherDisplayViewModel()
    var body: some View {
        
        structure()
            .padding()
            .background(theme.weatherBackground)
            .cornerRadius(12)
            
        
    }
    
    
    func structure() -> some View {
        return VStack {
            HStack {
                
                VStack {
                    Text("City Name")
                        .fontDesign(.rounded)
                        .padding(.bottom, 2)
                        .foregroundColor(theme.textColor)
                    Text("72°")
                        .font(.largeTitle)
                        .fontDesign(.rounded)
                        .foregroundColor(theme.textColor)
                }
                Spacer()
                VStack {
                    Image(systemName: "sun.max.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.yellow)
                    Text("Mostly Sunny")
                        .foregroundColor(theme.textColor)
                        .fontDesign(.rounded)
                    HStack {
                        Text("H: 63°")
                            .foregroundColor(theme.textColor)
                            .fontDesign(.rounded)
                        Text("L: 52°")
                            .foregroundColor(theme.textColor)
                            .fontDesign(.rounded)
                    }
                }
                
                
                
                
            }
            .padding()
            
            hourlyWeatherHStack()
        }
        
    }
    
    
    
    func hourlyWeatherHStack() -> some View {
        
        let times = ["12PM", "1PM", "2PM", "3PM", "4PM", "5PM"]
        
        return HStack {
            ForEach(times, id: \.self) { time in
                hourlyForecast(time: time)
            }
            .padding(.horizontal, 5)
        }
    }
    
    
    func hourlyForecast(time: String) -> some View {
        return VStack {
            Text(time)
                .fontDesign(.rounded)
                .foregroundColor(theme.textColor)
            Image(systemName: "sun.max.fill")
                .resizable()
                .frame(width: 25, height: 25)
                .foregroundColor(.yellow)
                .padding(.vertical, 5)
            Text("61°")
                .fontDesign(.rounded)
                .foregroundColor(theme.textColor)
                .padding(.vertical, 5)
            
        }
        
        
    }
    
}

struct OnboardingWeatherDisplayView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingWeatherDisplayView(theme: .constant(Theme(name: "themeName",
                                                            textColor: .white,
                                                            backgroundColor: .indigo,
                                                            weatherBackground: Color("Background"),
                                                            accentColor: .yellow)))
    }
}
