//
//  SettingsView.swift
//  Weather Provider
//
//  Created by Matthew Sousa on 12/13/23.
//

import SwiftUI

@available(iOS 17.0, *)
struct SettingsView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @EnvironmentObject var userDelegate: UserDelegate
    
    

    var body: some View {
        NavigationStack {
            Background(themeManager.currentTheme) {
                
                VStack(alignment: .trailing) {
                    header()
                    List {
                        
                        NavigationLink {
                            ThemePickerView()
                                .environmentObject(themeManager)
                                .environmentObject(userDelegate)
                        } label: {
                            WPText("Select Theme", themeManager.currentTheme)
                                .padding()
                                
                        }
                        .listRowBackground(themeManager.currentTheme.weatherBackground)

                        
                        WPText("Select Theme", themeManager.currentTheme)
                            .listRowBackground(themeManager.currentTheme.weatherBackground)
                            .padding()
                        
                        WPText("Saved Locations", themeManager.currentTheme)
                            .listRowBackground(themeManager.currentTheme.weatherBackground)
                            .padding()
                        
                        WPText("Temperature Measurement", themeManager.currentTheme)
                            .listRowBackground(themeManager.currentTheme.weatherBackground)
                            .padding()
                            
                    }
                    
                    
                    .background(themeManager.currentTheme.backgroundColor)
                    
                    .scrollContentBackground(.hidden)
                    Spacer()
                }
                
            }
            
        }
    }
    
}

@available(iOS 17.0, *)
extension SettingsView {
    
    /// Displays the Settings Title
    func header() -> some View {
        HStack {
            WPOTitle("Settings",
                     color: themeManager.currentTheme.textColor)
                .padding()
            Spacer()
        }
    }
}

@available(iOS 17.0, *)
#Preview {
    SettingsView()
        .environmentObject(ThemeManager() )
        .environmentObject(UserDelegate() )
}
