//
//  UserDelegateAttribute.swift
//  Weather Provider
//
//  Created by Matthew Sousa on 12/7/23.
//

import Foundation

/// This Structure is used to handle the saved data associated with the User
struct UserDelegateAttribute: Codable, CustomStringConvertible {
    var id: String
    var didCompleteOnboarding: Bool
    var savedLocations: [Location]
    var theme: String // Use to match existing themes - maybe add an id property to Theme to compare to
    var temperatureMeasurement: TemperatureMeasurement // Fahrenheit or Celcius
    var sendAlertsIsActive: Bool
    
    init(id: String,
         didCompleteOnboarding: Bool = false,
         savedLocations: [Location] = [],
         theme: String = ThemeList.one.theme.name,
         temperatureMeasurement: TemperatureMeasurement = .fahrenheit,
         sendAlertsIsActive: Bool = false) {
        self.id = id
        self.didCompleteOnboarding = didCompleteOnboarding
        self.savedLocations = savedLocations
        self.theme = theme
        self.temperatureMeasurement = temperatureMeasurement
        self.sendAlertsIsActive = sendAlertsIsActive
    }
    
    var description: String { 
        
        return "\nUserDelegate ---\nID: \(id),\ndidCompleteOnboarding: \(didCompleteOnboarding),\nsavedLocations: \(savedLocations),\ntheme: \(theme),\ntemperatureMeasurement: \(temperatureMeasurement),\nsendAlertsIsActive: \(sendAlertsIsActive)"
        
        
    }
}

