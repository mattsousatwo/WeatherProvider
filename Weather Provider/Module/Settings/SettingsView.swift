//
//  SettingsView.swift
//  Weather Provider
//
//  Created by Matthew Sousa on 12/13/23.
//

import SwiftUI

@available(iOS 17.0, *)
struct SettingsView: View {
    @EnvironmentObject var userDelegate: UserDelegate
    
    

    var body: some View {
        NavigationStack {
            Background(displayType: .two, userDelegate.theme) {
                
                VStack(alignment: .trailing) {
                    header()
                    List {
                        
                        Section {
                            NavigationLink {
                                ThemePickerView()
                                    .environmentObject(userDelegate)
                            } label: {
                                WPText("Select a Theme", userDelegate.theme)
                                    .padding()
                            }
                            .listRowBackground(userDelegate.theme.weatherBackground)
                            
                            NavigationLink {
                                Text("Saved Locations")
                                    .environmentObject(userDelegate)
                            } label: {
                                WPText("Saved Locations (Not Setup)", userDelegate.theme)
                                    .padding()
                            }
                            .listRowBackground(userDelegate.theme.weatherBackground)
                            
                            NavigationLink {
                                Text("Weather Highlights")
                                    .environmentObject(userDelegate)
                            } label: {
                                WPText("Weather Highlights (Not Setup)", userDelegate.theme)
                                    .padding()
                            }
                            .listRowBackground(userDelegate.theme.weatherBackground)
                        }
                        
                        
                        Section {
                            ToggleRow("Multi-Color Symbols") {
                                
                            }
                            .listRowBackground(userDelegate.theme.weatherBackground)
                            
                            ToggleRow("Temp. Measurement") {
                                
                            }
                            .listRowBackground(userDelegate.theme.weatherBackground)
                            
                            ToggleRow("Display Past Hours") {
                                
                            }
                            .listRowBackground(userDelegate.theme.weatherBackground)
                            
                        }
                    }
                    .shadow(radius: 2, x: 0, y: 2)
                    .scrollContentBackground(.hidden)
                    .tint(userDelegate.theme.weatherBackground)
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
                     color: userDelegate.theme.textColor)
                .padding()
            Spacer()
        }
    }
}

@available(iOS 17.0, *)
#Preview {
    SettingsView()
        .environmentObject(UserDelegate() )
}
