//
//  Forecast.swift
//  Weather Provider
//
//  Created by Matthew Sousa on 12/18/23.
//

import Foundation

// MARK: - Forecast
struct Forecast: Codable, Equatable {
    var forecastday: [Forecastday]
}
