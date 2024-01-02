//
//  AirQuality.swift
//  Weather Provider
//
//  Created by Matthew Sousa on 12/18/23.
//

import Foundation

struct AirQuality: Codable {
    /// Carbon Monoxide (μg/m3)
    let carbonMonoxide: Double
    /// Nitorgen Dioxide (μg/m3)
    let nitrogenDioxide: Double
    /// Ozone (μg/m3)
    let ozone: Double
    /// Sulpher Dioxide (μg/m3)
    let sulfurDioxide: Double
    /// PM2.5 (μg/m3)
    let pm2_5: Double
    /// PM10 (μg/m3)
    let pm10: Double
    /// US - EPA Standard: 1-Good, 2-Moderate, 3-Unhealthy for Sensative Group, 4-Unhealthy, 5-Very Unhealthy, 6-Hazardous
    let usEPAIndex: Int
    /// UK Defra Index: 1-3 Low, 4-6 Moderate, 7-9 High, 10 Very High
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
