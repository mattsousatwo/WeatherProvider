//
//  UserDelegateAttribute.swift
//  Weather Provider
//
//  Created by Matthew Sousa on 12/7/23.
//

import Foundation

/// This Structure is used to handle the saved data associated with the User
struct UserDelegateAttribute: Codable {
    var id: String
    var didCompleteOnboarding: Bool
    var userLocation: String
    var theme: String // Use to match existing themes - maybe add an id property to Theme to compare to
    var temperatureMeasurement: TemperatureMeasurement // Fahrenheit or Celcius
    var sendAlertsIsActive: Bool
}

