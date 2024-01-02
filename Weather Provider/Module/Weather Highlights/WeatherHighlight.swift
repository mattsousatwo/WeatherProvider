//
//  WeatherHighlight.swift
//  Weather Provider
//
//  Created by Matthew Sousa on 12/29/23.
//

import SwiftUI

struct WeatherHighlight: View {
    @EnvironmentObject var userDelegate: UserDelegate
    
    private let imageSize: CGFloat = 40
    private let frameHeight: CGFloat = 200
    private let frameWidth: CGFloat = (UIScreen.main.bounds.width / 3) * 0.83
    let type: HighlightType
    let order: Order
    let weather: WeatherInfo
    
    var body: some View {
//        NavigationLink {
//            Text("Hello World - \(weather.forecast.forecastday.count)")
//        } label: {
//            switch order {
//                case .first:
//                    one()
//                case .second:
//                    two()
//                case .third:
//                    three()
//            }
//        }
        
        
        
        Button {
            
        } label: {
            HighlightBackground(order: order,
                                label: {
                Text(type.title)
            }, image: {
                type.image
                    .renderingMode(.original) // 1 Rendering mode will allow the image to be multicolored
                    .resizable()
                    .frame(width: type.imageWidth, height: type.imageHeight)
                    .foregroundStyle(userDelegate.theme.textColor)
                    .shadow(radius: 1, x: 0, y: 1)
            }, detail: {
                Text(type.detail)
            })
            
        }
        
        
    }
    
    func one() -> some View {
        RoundedRectangle(cornerRadius: 12)
            .frame(width: frameWidth, height: frameHeight)
            .foregroundStyle(userDelegate.theme.backgroundColor)
            .overlay(alignment: .center) {
                RoundedRectangle(cornerRadius: 12)
                    .frame(width: frameWidth, height: frameHeight)
                    .foregroundStyle(.black)
                    .opacity(0.05)
            }
            .overlay(alignment: .bottom) {
                RoundedRectangle(cornerRadius: 0)
                    .frame(width: frameWidth, height: frameHeight / 2)
                    .foregroundStyle(userDelegate.theme.weatherBackground)
                    .roundedCorner(50, corners: .topLeft)
            }
            .overlay(alignment: .center) {
                type.image
                    .renderingMode(.original) // 1
                    .resizable()
                    .frame(width: type.imageWidth, height: type.imageHeight)
                    .foregroundStyle(userDelegate.theme.textColor)
                    .shadow(radius: 1, x: 0, y: 1)
            }
            .overlay(alignment: .top) {
                Text(type.title)
                    .multilineTextAlignment(.center)
                    .bold()
                    .fontDesign(.rounded)
                    .foregroundStyle(userDelegate.theme.textColor)
                    .padding()
            }
            .overlay(alignment: .bottom) {
                Text(type.detail)
                    .multilineTextAlignment(.center)
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
            .frame(width: frameWidth, height: frameHeight)
            .foregroundStyle(userDelegate.theme.backgroundColor)
            .overlay(alignment: .center) {
                RoundedRectangle(cornerRadius: 12)
                    .frame(width: frameWidth, height: frameHeight)
                    .foregroundStyle(.black)
                    .opacity(0.05)
            }
            .overlay(alignment: .bottom) {
                RoundedRectangle(cornerRadius: 0)
                    .frame(width: frameWidth, height: frameHeight / 2)
                    .foregroundStyle(userDelegate.theme.weatherBackground)
                //                    .roundedCorner(50, corners: .topLeft)
            }
            .overlay(alignment: .center) {
                type.image
                    .renderingMode(.original) // 1
                    .resizable()
                    .frame(width: type.imageWidth, height: type.imageHeight)
                    .foregroundStyle(userDelegate.theme.textColor)
                    .shadow(radius: 1, x: 0, y: 1)
            }
            .overlay(alignment: .top) {
                Text(type.title)
                    .multilineTextAlignment(.center)
                    .bold()
                    .fontDesign(.rounded)
                    .foregroundStyle(userDelegate.theme.textColor)
                    .padding()
            }
            .overlay(alignment: .bottom) {
                Text(type.detail)
                    .multilineTextAlignment(.center)
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
            .frame(width: frameWidth, height: frameHeight)
            .foregroundStyle(userDelegate.theme.weatherBackground)
            .overlay(alignment: .top) {
                RoundedRectangle(cornerRadius: 0)
                    .frame(width: frameWidth, height: frameHeight / 2)
                    .foregroundStyle(userDelegate.theme.backgroundColor)
                    .roundedCorner(50, corners: .bottomRight)
                    .overlay(alignment: .center) {
                        RoundedRectangle(cornerRadius: 0)
                            .frame(width: frameWidth, height: frameHeight / 2)
                            .foregroundStyle(.black)
                            .opacity(0.05)
                            .roundedCorner(50, corners: .bottomRight)
                    }
            }
            .overlay(alignment: .center) {
                type.image
                    .renderingMode(.original) // 1 Rendering mode will allow the image to be multicolored
                    .resizable()
                    .frame(width: type.imageWidth, height: type.imageHeight)
                    .foregroundStyle(userDelegate.theme.textColor)
                    .shadow(radius: 1, x: 0, y: 1)
            }
            .overlay(alignment: .top) {
                Text(type.title)
                    .multilineTextAlignment(.center)
                    .bold()
                    .fontDesign(.rounded)
                    .foregroundStyle(userDelegate.theme.textColor)
                    .padding()
            }
            .overlay(alignment: .bottom) {
                Text(type.detail)
                    .multilineTextAlignment(.center)
                    .fontWeight(.light)
                    .fontDesign(.rounded)
                    .foregroundStyle(userDelegate.theme.textColor)
                    .padding()
            }
            .roundedCorner(12, corners: [.topLeft, .topRight])
            .shadow(radius: 5, x: 0, y: 1)
        
    }
}

#Preview {
    let theme = UserDelegate()
    theme.theme = ThemeList.four.theme
    
    let currentWeather = CurrentWeather(lastUpdatedEpoch: 1, lastUpdated: "", temperatureCelsius: 0.0, temperatureFahrenheit: 0.0, isDay: 1, condition: Condition(text: "", icon: "", code: 0), windMph: 0.0, windKph: 0.0, windDegree: 0, windDirection: "", pressureMb: 0.0, pressureIn: 0.0, precipitationMm: 0.0, precipitationIn: 0.0, humidity: 0, cloudCover: 0, feelsLikeCelsius: 0.0, feelsLikeFahrenheit: 0.0, visibilityKm: 0.0, visibilityMiles: 0.0, uvIndex: 0.0, gustMph: 0.0, gustKph: 0.0, airQuality: nil)
    let location = Location(name: "", region: "", country: "", latitude: 0.0, longitude: 0.0, timezoneID: "", localTimeEpoch: 0, localTime: "")
    let astro = Astro(sunrise: "", sunset: "", moonrise: "", moonset: "", moonPhase: "", isMoonUp: 0, isSunUp: 1, moonIllumination: 1)
    let condition = Condition(text: "", icon: "", code: 1)
    let day = Day(maxtempC: 0.0, maxtempF: 0.0, mintempC: 0.0, mintempF: 0.0, avgtempC: 0.0, avgtempF: 0.0, maxwindMph: 0.0, maxwindKph: 0.0, totalprecipMm: 0.0, totalprecipIn: 0.0, totalsnowCM: 0.0, avgvisKM: 0.0, avgvisMiles: 0.0, avghumidity: 0.0, dailyWillItRain: 0, dailyChanceOfRain: 0, dailyWillItSnow: 1, dailyChanceOfSnow: 0, condition: condition, uv: 1)
    let hour = [Hour(timeEpoch: 1, time: "", tempC: 0.0, tempF: 0.0, isDay: 0, condition: condition, windMph: 0.0, windKph: 0.0, windDegree: 0, windDir: "", pressureMB: 0, pressureIn: 0.0, precipMm: 0.0, precipIn: 0.0, humidity: 0, cloud: 0, feelslikeC: 0.0, feelslikeF: 0.0, windchillC: 0.0, windchillF: 0.0, heatindexC: 0.0, heatindexF: 0.0, dewpointC: 0.0, dewpointF: 0.0, willItRain: 0, chanceOfRain: 0, willItSnow: 0, chanceOfSnow: 0, visKM: 0, visMiles: 0, gustMph: 0.0, gustKph: 0.0, uv: 0)]
    
    let weather = WeatherInfo(location: location,
                              currentWeather: currentWeather,
                              forecast: Forecast(forecastday: [Forecastday(date: "", dateEpoch: 0, day: day, astro: astro, hour: hour)]))
    
    return Background(displayType: .one, theme.theme, content: {
        VStack {
            HStack {
                WeatherHighlight(type: .airQuality(weather: weather), order: .first, weather: weather)
                WeatherHighlight(type: .airQuality(weather: weather), order: .second, weather: weather)
                    .padding()
                WeatherHighlight(type: .airQuality(weather: weather), order: .third, weather: weather)
            }
            HStack {
                WeatherHighlight(type: .moon(weather: weather), order: .first, weather: weather)
                WeatherHighlight(type: .feelsLike(weather: weather), order: .second, weather: weather)
                    .padding()
                WeatherHighlight(type: .percipitation(weather: weather), order: .third, weather: weather)
            }
            HStack {
                WeatherHighlight(type: .uv(weather: weather), order: .first, weather: weather)
                WeatherHighlight(type: .wind(weather: weather), order: .second, weather: weather)
                    .padding()
                WeatherHighlight(type: .humidity(weather: weather), order: .third, weather: weather)
            }
        }
        
    })
    .environmentObject(theme )
}


extension WeatherHighlight {
    struct HighlightBackground<Label: View, Image: View, Detail: View>: View {
        @ViewBuilder var label: Label
        @ViewBuilder var image: Image
        @ViewBuilder var detail: Detail
        let theme: Theme
        let order: Order
        private let imageSize: CGFloat = 40
        private let frameHeight: CGFloat = 200
        private let frameWidth: CGFloat = (UIScreen.main.bounds.width / 3) * 0.83

        
        init(order: Order,
             _ theme: Theme = ThemeList.four.theme,
             @ViewBuilder label: () -> Label,
             @ViewBuilder image: () -> Image,
             @ViewBuilder detail: () -> Detail) {
            self.order = order
            self.theme = theme
            self.label = label()
            self.image = image()
            self.detail = detail()
        }
        
        var body: some View {
            background()
                .overlay(alignment: order == .third ? .top : .center) {
                    if order == .third {
                        thirdOverlay()
                    } else {
                        firstAndSecondOverlayCenter()
                    }
                }
                .overlay(alignment: .bottom) {
                    if order != .third {
                        firstAndSecondOverlayBottom()
                    }
                }
                .overlay(alignment: .top) {
                    label
                        .multilineTextAlignment(.center)
                        .bold()
                        .fontDesign(.rounded)
                        .foregroundStyle(theme.textColor)
                        .padding()
                }
                .overlay(alignment: .center) {
                    image
                }
                .overlay(alignment: .bottom) {
                    detail
                        .multilineTextAlignment(.center)
                        .fontWeight(.light)
                        .fontDesign(.rounded)
                        .foregroundStyle(theme.textColor)
                        .padding()
                }
                .roundedCorner(12, corners: order != .third ? [.bottomLeft, .bottomRight] : [.topLeft, .topRight])
                .shadow(radius: 5, x: 0, y: 1)
        }
        
        func background() -> some View {
            RoundedRectangle(cornerRadius: 12)
                .frame(width: frameWidth, height: frameHeight)
                .foregroundStyle(order != .third ? theme.backgroundColor : theme.weatherBackground)
        }
        
        // Top
        func thirdOverlay() -> some View {
            RoundedRectangle(cornerRadius: 0)
                .frame(width: frameWidth, height: frameHeight / 2)
                .foregroundStyle(theme.backgroundColor)
                .roundedCorner(50, corners: .bottomRight)
                .overlay(alignment: .center) {
                    RoundedRectangle(cornerRadius: 0)
                        .frame(width: frameWidth, height: frameHeight / 2)
                        .foregroundStyle(.black)
                        .opacity(0.05)
                        .roundedCorner(50, corners: .bottomRight)
                }
        }
        
        // Center
        func firstAndSecondOverlayCenter() -> some View {
                RoundedRectangle(cornerRadius: 12)
                    .frame(width: frameWidth, height: frameHeight)
                    .foregroundStyle(.black)
                    .opacity(0.05)
                    
        }
        
        // Bottom
        func firstAndSecondOverlayBottom() -> some View {
            RoundedRectangle(cornerRadius: 0)
                .frame(width: frameWidth, height: frameHeight / 2)
                .foregroundStyle(theme.weatherBackground)
                .roundedCorner(order == .first ? 50 : 0, corners: .topLeft)
        }

        
        
        
        
    }
}
