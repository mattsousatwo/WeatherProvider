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
    
    @State private var multiColorSymbols: Bool = false
    @State private var tempMeasurementToggle: Bool = false
    @State private var tempMeasurement: TemperatureMeasurement = .fahrenheit
    @State private var displayPastHours: Bool = false
    
    
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
                                SavedLocations()
                                    .environmentObject(userDelegate)
                            } label: {
                                WPText("Saved Locations", userDelegate.theme)
                                    .padding()
                            }
                            .listRowBackground(userDelegate.theme.weatherBackground)
                            
                            NavigationLink {
                                WeatherHighlightsSettings()
                                    .environmentObject(userDelegate)
                            } label: {
                                WPText("Weather Highlights", userDelegate.theme)
                                    .padding()
                            }
                            .listRowBackground(userDelegate.theme.weatherBackground)
                        }
                        
                        
                        Section {
//                                                        ToggleRow("Multi-Color Symbols") {
//                            
//                                                        }
//                                                        .listRowBackground(userDelegate.theme.weatherBackground)
                            
                            toggle("Multi-Color Symbols", toggle: $multiColorSymbols)
                                .onAppear {
                                    multiColorSymbols = userDelegate.multiColorSymbols
                                }
                                .onChange(of: multiColorSymbols) { oldValue, newValue in
                                    userDelegate.toggleMultiColorSymbols()
                                    
                                }
                            
                            toggle("Temp. Measurement", toggle: $tempMeasurementToggle)
                                .onChange(of: tempMeasurementToggle) { oldValue, newValue in
                                    userDelegate.toggleTempMeasurement(tempMeasurementToggle)
                                }
                                .onAppear {
                                    switch userDelegate.tempMeasurement {
                                        case .fahrenheit:
                                            tempMeasurement = .fahrenheit
                                            tempMeasurementToggle = false 
                                        case .celsius:
                                            tempMeasurement = .celsius
                                            tempMeasurementToggle = true
                                    }
                                }

                            toggle("Display Past Hours", toggle: $displayPastHours)
                                .onAppear {
                                    displayPastHours = userDelegate.displayPastHours 
                                }
                                .onChange(of: displayPastHours) { oldValue, newValue in
                                    userDelegate.toggleDisplayPastHours()
                                }

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
    
    
    func toggle(_ title: String, toggle: Binding<Bool>) -> some View {
        HStack {
            WPText(title, userDelegate.theme)
            Spacer()
            
//            ZStack {
                Capsule()
                    .foregroundStyle(userDelegate.theme.textColor.opacity(0.1))
                    .frame(width: 50)
                    .overlay {
                        Toggle("", isOn: toggle)
                            .labelsHidden()
                            .tint(userDelegate.theme.textColor)
                    }
                    .shadow(radius: 1, x: 0, y: 1)

//            }
        }
        .padding()
        .listRowBackground(userDelegate.theme.weatherBackground)
    }
}

@available(iOS 17.0, *)
#Preview {
    SettingsView()
        .environmentObject(UserDelegate() )
}
