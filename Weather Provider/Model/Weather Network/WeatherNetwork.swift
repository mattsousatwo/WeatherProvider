//
//  WeatherNetwork.swift
//  Weather Provider
//
//  Created by Matthew Sousa on 5/22/23.
//
import Foundation
import Combine

/// Responsible for all calls made to the Weather Network
public class WeatherNetwork: ObservableObject {
    
    private let session: URLSession
    private let sessionConfig: URLSessionConfiguration
    
    init() {
        self.sessionConfig = URLSessionConfiguration.default
        self.session = URLSession(configuration: sessionConfig)
    }
    
    /// /// Fetching ten day forecast in a location
    /// - **Parameter** location: Location is a string variable and can be interprated as a City Name, Zip Code, Postcode, or Longitude/Latitude (ex: q=48.8567,2.3508)
    func fetchTenDayForecast(in location: String) async throws -> WeatherInfo? {
        guard let tenDayForecastURL = URL(string: "https://api.weatherapi.com/v1/forecast.json?key=5758522f634f4581bd1133838210407&q=\(location)&days=10&aqi=no&alerts=no") else {
            return nil
        }
        
        print("Fetch Weather for: \(location)")
        let (data, response) = try await session.data(from: tenDayForecastURL)
        guard let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200
                
        else {
            print("HTTPstatuscode != 200, \(response.description)")
            return nil
        }
    
        let s = String(data: data, encoding: .utf8)
        guard let decodedString = s else {
            print("String was not decoded")
            return nil
        }
        
        do {
            let weatherInfo = try JSONDecoder().decode(WeatherInfo.self, from: data)
            // You can now access the decoded objects
            print(weatherInfo.location.name)
            print(weatherInfo.currentWeather.temperatureFahrenheit)
            
            return weatherInfo
        } catch {
            print("Error decoding JSON: \(error)")
        }
        print("Fetched Data: \(data.count), \(decodedString)")
        return nil 
    }
    
}



