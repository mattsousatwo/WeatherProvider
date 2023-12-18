//
//  AirQuality.swift
//  Weather Provider
//
//  Created by Matthew Sousa on 12/18/23.
//

import Foundation

struct AirQuality: Codable {
    let carbonMonoxide: Double
    let nitrogenDioxide: Double
    let ozone: Double
    let sulfurDioxide: Double
    let pm2_5: Double
    let pm10: Double
    let usEPAIndex: Int
    let gbDefraIndex: Int
    
    enum CodingKeys: String, CodingKey {
        case carbonMonoxide = "co"
        case nitrogenDioxide = "no2"
        case ozone = "o3"
        case sulfurDioxide = "so2"
        case pm2_5 = "pm2_5"
        case pm10
        case usEPAIndex = "us-epa-index"
        case gbDefraIndex = "gb-defra-index"
    }
}
