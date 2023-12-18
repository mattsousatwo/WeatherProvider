//
//  ForecastDay.swift
//  Weather Provider
//
//  Created by Matthew Sousa on 12/18/23.
//

import Foundation

struct Forecastday: Codable, Equatable, Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(date)
    }
    
    static func == (lhs: Forecastday, rhs: Forecastday) -> Bool {
        return lhs.date == rhs.date &&
        lhs.dateEpoch == rhs.dateEpoch
    }
    
    
    var date: String
    var dateEpoch: Int
    var day: Day
    var astro: Astro
    var hour: [Hour]
    
    enum CodingKeys: String, CodingKey {
        case date
        case dateEpoch = "date_epoch"
        case day, astro, hour
    }
}
