//
//  Astro.swift
//  Weather Provider
//
//  Created by Matthew Sousa on 12/18/23.
//

import Foundation

struct Astro: Codable {
    var sunrise, sunset, moonrise, moonset, moonPhase: String
    var isMoonUp, isSunUp, moonIllumination: Int
    
    enum CodingKeys: String, CodingKey {
        case sunrise, sunset, moonrise, moonset
        case moonPhase = "moon_phase"
        case moonIllumination = "moon_illumination"
        case isMoonUp = "is_moon_up"
        case isSunUp = "is_sun_up"
    }
}
