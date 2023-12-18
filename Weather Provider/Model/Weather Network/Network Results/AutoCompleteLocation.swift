//
//  AutoCompleteLocation.swift
//  Weather Provider
//
//  Created by Matthew Sousa on 12/18/23.
//

import Foundation

struct AutoCompleteLocation: Codable, Equatable {
    let id: Double
    let name: String
    let region: String
    let country: String
    let latitude: Double
    let longitude: Double
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case region = "region"
        case country = "country"
        case latitude = "lat"
        case longitude = "lon"
        case url = "url"
    }
    
    func asLocation() -> Location {
        return Location(name: self.name, region: self.region, country: self.country, latitude: self.latitude, longitude: self.longitude)
    }
}
