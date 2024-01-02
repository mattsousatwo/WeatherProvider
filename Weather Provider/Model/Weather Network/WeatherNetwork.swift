//
//  WeatherNetwork.swift
//  Weather Provider
//
//  Created by Matthew Sousa on 5/22/23.
//
import Foundation
import Combine

/// Responsible for all calls made to the Weather Network
public class WeatherNetwork: LoadingClass, ObservableObject {
    
    private let session: URLSession
    private let sessionConfig: URLSessionConfiguration
    
    override init() {
        self.sessionConfig = URLSessionConfiguration.default
        self.session = URLSession(configuration: sessionConfig)
    }
    
    /// /// Fetching ten day forecast in a location
    /// - **Parameter** location: Location is a string variable and can be interprated as a City Name, Zip Code, Postcode, or Longitude/Latitude (ex: q=48.8567,2.3508)
    func fetchTenDayForecast(in location: String) async throws -> WeatherInfo? {
        print("Fetch Weather for: \(location)")
        guard let tenDayForecastURL = URL(string: "https://api.weatherapi.com/v1/forecast.json?key=5758522f634f4581bd1133838210407&q=\(location)&days=10&aqi=yes&alerts=no") else {
            return nil
        }
        
        
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
            
            print("Fetched Data: \(data.count)")
//            print("Fetched Data: \(data.count), \(decodedString)")
            return weatherInfo
        } catch {
            print("Error decoding JSON: \(error)")
            print("Fetched Data: \(data.count), \(decodedString)")
        }
        return nil 
    }
    
    
    // Search the WeatherAPI for a new location - will return an array of autocomplete results
    func searchAutoComplete(for location: String) async throws -> [AutoCompleteLocation] {
        guard let request = URL(string: "https://api.weatherapi.com/v1/search.json?key=5758522f634f4581bd1133838210407&q=\(location)") else { return [] }
        let (data, response) = try await session.data(from: request)
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200
        else {
            print("HTTPstatuscode != 200, \(response.description)")
            return []
        }
        do {
            let autoCompleteResults = try decoder.decode([AutoCompleteLocation].self, from: data)
            print("AutoCompleteResults : \(autoCompleteResults)")
            return autoCompleteResults
        } catch {
            print("ACT - 7 - autoComplete decode catch")
        }
        return []
    }
    
}



