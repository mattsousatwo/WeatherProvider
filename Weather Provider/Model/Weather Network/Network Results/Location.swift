//
//  Location.swift
//  Weather Provider
//
//  Created by Matthew Sousa on 12/18/23.
//

import Foundation


struct Location: Codable, Equatable, CustomStringConvertible, Hashable {
    let name: String
    let region: String
    let country: String
    let latitude: Double
    let longitude: Double
    let timezoneID: String
    let localTimeEpoch: Int
    let localTime: String
    
    init(name: String, region: String, country: String, latitude: Double, longitude: Double, timezoneID: String = "", localTimeEpoch: Int = 0, localTime: String = "") {
        self.name = name
        self.region = region
        self.country = country
        self.latitude = latitude
        self.longitude = longitude
        self.timezoneID = timezoneID
        self.localTimeEpoch = localTimeEpoch
        self.localTime = localTime
    }
    
    enum CodingKeys: String, CodingKey {
        case name, region, country
        case latitude = "lat"
        case longitude = "lon"
        case timezoneID = "tz_id"
        case localTimeEpoch = "localtime_epoch"
        case localTime = "localtime"
    }
    
    var description: String {
        return "\(name), \(region), \(country), (lon: \(longitude), lat: \(latitude))\n"
    }
    
    /// Returns a string with the users longitude and latitude
    var longituteAndLatitude: String {
        let lat = "\(latitude)"
        let long = "\(longitude)"
        return lat + "," + long
    }
    
    static func ==(lhs: Location, rhs: Location) -> Bool {
        return lhs.name == rhs.name &&
        lhs.region == rhs.region &&
        lhs.country == rhs.country
    }
}
