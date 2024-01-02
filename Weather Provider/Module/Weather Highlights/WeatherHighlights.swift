//
//  WeatherHighlight.swift
//  Weather Provider
//
//  Created by Matthew Sousa on 12/19/23.
//

import SwiftUI

struct WeatherHighlights: View {
    @EnvironmentObject var userDelegate: UserDelegate
    
    let weather: WeatherInfo 
    private let imageSize: CGFloat = 40
    
    var body: some View {
        HStack {
            Spacer()
            WeatherHighlight(type: .wind(weather: weather), order: .first, weather: weather)
            Spacer()
            WeatherHighlight(type: .moon(weather: weather), order: .second, weather: weather)
            Spacer()
            WeatherHighlight(type: .uv(weather: weather), order: .third, weather: weather)
            Spacer()
        }
        .padding(.vertical)
    }
    
    func one() -> some View {
        RoundedRectangle(cornerRadius: 12)
            .frame(width: 100, height: 200)
            .foregroundStyle(userDelegate.theme.backgroundColor)
            .overlay(alignment: .center) {
                RoundedRectangle(cornerRadius: 12)
                    .frame(width: 100, height: 200)
                    .foregroundStyle(.black)
                    .opacity(0.05)
            }
            .overlay(alignment: .bottom) {
                RoundedRectangle(cornerRadius: 0)
                    .frame(width: 100, height: 100)
                    .foregroundStyle(userDelegate.theme.weatherBackground)
                    .roundedCorner(50, corners: .topLeft)
            }
            .overlay(alignment: .center) {
                Image(systemName: "sun.max.fill")
                    .renderingMode(.original) // 1
                    .resizable()
                    .frame(width: imageSize, height: imageSize)
                    .foregroundStyle(userDelegate.theme.textColor)
                    .shadow(radius: 1, x: 0, y: 1)
            }
            .overlay(alignment: .top) {
                Text("2:00PM")
                    .bold()
                    .fontDesign(.rounded)
                    .foregroundStyle(userDelegate.theme.textColor)
                    .padding()
            }
            .overlay(alignment: .bottom) {
                Text("12.5%")
                    .fontWeight(.light)
                    .fontDesign(.rounded)
                    .foregroundStyle(userDelegate.theme.textColor)
                    .padding()
            }
            .roundedCorner(12, corners: [.bottomLeft, .bottomRight])
            .shadow(radius: 5, x: 0, y: 1)

    }
    
    func two() -> some View {
        RoundedRectangle(cornerRadius: 12)
            .frame(width: 100, height: 200)
            .foregroundStyle(userDelegate.theme.backgroundColor)
            .overlay(alignment: .center) {
                RoundedRectangle(cornerRadius: 12)
                    .frame(width: 100, height: 200)
                    .foregroundStyle(.black)
                    .opacity(0.05)
            }
            .overlay(alignment: .bottom) {
                RoundedRectangle(cornerRadius: 0)
                    .frame(width: 100, height: 100)
                    .foregroundStyle(userDelegate.theme.weatherBackground)
//                    .roundedCorner(50, corners: .topLeft)
            }
            .overlay(alignment: .center) {
                Image(systemName: "cloud.rain")
                    .renderingMode(.original) // 1
                    .resizable()
                    .frame(width: imageSize, height: imageSize)
                    .foregroundStyle(userDelegate.theme.textColor)
                    .shadow(radius: 1, x: 0, y: 1)
            }
            .overlay(alignment: .top) {
                Text("1:00PM")
                    .bold()
                    .fontDesign(.rounded)
                    .foregroundStyle(userDelegate.theme.textColor)
                    .padding()
            }
            .overlay(alignment: .bottom) {
                Text("2 in.")
                    .fontWeight(.light)
                    .fontDesign(.rounded)
                    .foregroundStyle(userDelegate.theme.textColor)
                    .padding()
            }
            .roundedCorner(12, corners: [.bottomLeft, .bottomRight])
            .shadow(radius: 5, x: 0, y: 1)
    }
    
    func three() -> some View {
        RoundedRectangle(cornerRadius: 12)
            .frame(width: 100, height: 200)
            .foregroundStyle(userDelegate.theme.weatherBackground)
            .overlay(alignment: .top) {
                RoundedRectangle(cornerRadius: 0)
                    .frame(width: 100, height: 100)
                    .foregroundStyle(userDelegate.theme.backgroundColor)
                    .roundedCorner(50, corners: .bottomRight)
                    .overlay(alignment: .center) {
                        RoundedRectangle(cornerRadius: 0)
                            .frame(width: 100, height: 100)
                            .foregroundStyle(.black)
                            .opacity(0.05)
                            .roundedCorner(50, corners: .bottomRight)
                    }
            }
            .overlay(alignment: .center) {
                Image(systemName: "sun.max.trianglebadge.exclamationmark")
                    .renderingMode(.original) // 1 Rendering mode will allow the image to be multicolored
                    .resizable()
                    .frame(width: imageSize, height: imageSize)
                    .foregroundStyle(userDelegate.theme.textColor)
                    .shadow(radius: 1, x: 0, y: 1)
            }
            .overlay(alignment: .top) {
                Text("5:00PM")
                    .bold()
                    .fontDesign(.rounded)
                    .foregroundStyle(userDelegate.theme.textColor)
                    .padding()
            }
            .overlay(alignment: .bottom) {
                Text("34%")
                    .fontWeight(.light)
                    .fontDesign(.rounded)
                    .foregroundStyle(userDelegate.theme.textColor)
                    .padding()
            }
            .roundedCorner(12, corners: [.topLeft, .topRight])
            .shadow(radius: 5, x: 0, y: 1)

    }


}

//#Preview {
//    Background(UserDelegate().theme) {
//        WeatherHighlights(weather: <#T##WeatherInfo#>)
//            .environmentObject(UserDelegate() )
//    }
//}
