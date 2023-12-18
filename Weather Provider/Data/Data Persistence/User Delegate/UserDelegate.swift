//
//  UserDelegate.swift
//  Weather Provider
//
//  Created by Matthew Sousa on 12/7/23.
//

import Foundation
import SwiftUI

public class UserDelegate: LoadingClass, ObservableObject {
    
    private let userDelegateURL: URL = URL(fileURLWithPath: WPKeychain.userDelegateFile.rawValue,
                                           relativeTo: FileManager.documentsDirectoryURL).appendingPathExtension(WPKeychain.appendingPathExtension.rawValue)
    
    @Published var userAttributes: UserDelegateAttribute?
    @Published var delegateFileIsLoaded: Bool = false
    
    @Published var didCompleteOnboarding: Bool = false
    @Published var savedLocations: [Location] = []
    @Published var theme: Theme = ThemeList.one.theme
    @Published var tempMeasurement: TemperatureMeasurement = .fahrenheit
    @Published var sendAlertsIsActive: Bool = false

    override init() {
        super.init()
        if delegateFileIsLoaded == false {
            loadUserDelegateFile()
        }
    }
    
}


extension UserDelegate {
    
    /// Load delegate file from directory
    private func decodeUserDelegateFile() {
        print(#function)
        switch delegateFileIsLoaded {
            case false:
                guard let userDeletageData = try? Data(contentsOf: userDelegateURL) else {
                    createNewUserDelegateFile()
                    return
                }
                print("UserDelegateURL : \(userDelegateURL)")
                print("UserDelegateData - \(userDeletageData)")
                
                if userDeletageData.isEmpty {
                    print("UserDel is Empty ")
                }
            
                guard let decodedUserAttributes = try? decoder.decode(UserDelegateAttribute.self, from: userDeletageData) else {
                    createNewUserDelegateFile()
                    return
                }
                self.userAttributes = decodedUserAttributes
                
                // Set attributes to UserDelegate properties
                guard let userAttributes = userAttributes else { return }
                self.didCompleteOnboarding = userAttributes.didCompleteOnboarding
                self.savedLocations = userAttributes.savedLocations
                if let theme = matchTheme(name: userAttributes.theme) {
                    self.theme = theme
                }
                self.tempMeasurement = userAttributes.temperatureMeasurement
                self.sendAlertsIsActive = userAttributes.sendAlertsIsActive
                
                self.delegateFileIsLoaded = true
                
                print(userAttributes)
                print("\n")
            default:
                print(" is loaded ")
        }
    }
    
    /// Load from directory if avalible
    private func loadUserDelegateFile() {
        print(#function)
        switch delegateFileIsLoaded {
            case false:
                switch checkIfDirectoryExists(for: .userDelegateFile) {
                    case true:
                        decodeUserDelegateFile()
                    default:
                        createNewUserDelegateFile()
                }
            default:
                break
        }
    }
    
    
    /// Save the current UserDelegateAttributes to the UserDelegateFile in Documents Directory
    private func saveUserDelegate() {
        do {
            let encodedDelegateFile = try encoder.encode(userAttributes)
            if let delegateFileData = String(data: encodedDelegateFile, encoding: .utf8) {
                try delegateFileData.write(to: userDelegateURL,
                                           atomically: true,
                                           encoding: .utf8)
            }
        } catch {
            print(error, "Failed to save user delegate file")
        }
    }
    
    // Create New Delegate File
    private func createNewUserDelegateFile() {
        print(#function)
        self.userAttributes = UserDelegateAttribute(id: UUID().uuidString)
        saveUserDelegate()
    }
    
    /// Save that the user completed the onboarding phase
    func userDidCompleteOnboarding() {
        print(#function)
        self.didCompleteOnboarding = true
        userAttributes?.didCompleteOnboarding = true 
        saveUserDelegate()
    }
    
    /// Save the Themes Name to disk - will also set the ThemeManager currentTheme to this theme 
    func save(theme: Theme) {
        print(#function)
        self.userAttributes?.theme = theme.name
        if let userAttributesTheme = userAttributes?.theme {
            if let unwrappedTheme = matchTheme(name: userAttributesTheme) {
                self.theme = unwrappedTheme
            }

        }
        saveUserDelegate()
    }
    
    func save(location: Location) {
        print(#function)
        var shouldSave = true
        var foundMatch = false
        for savedLocation in self.savedLocations {
            if savedLocation.name == location.name &&
                savedLocation.region == location.region &&
                savedLocation.country == location.country {
                print("Location Already Saved")
                foundMatch = true
            }
        }
        if foundMatch == true {
            shouldSave = false
        }
        if shouldSave == true {
            self.userAttributes?.savedLocations.append(location)
            saveUserDelegate()
        }
    }
    
    /// Match the saved theme name to the existing theme list
    private func matchTheme(name: String) -> Theme? {
        print(#function)
        for themeElement in ThemeList.allCases {
            if themeElement.theme.name == name {
                print("Found Matching Theme -- \(themeElement.theme.name)")
                return themeElement.theme
            }
        }
        print("Missing Saved Theme")
        return nil
    }
    
}






extension UserDelegate {
    
//    func load() {
//        switch shouldCreateDelegate {
//            case true:
//                createNewUserDelegateFile()
//            case false:
//                
//        }
//    }
//    
//    
    
    
}
