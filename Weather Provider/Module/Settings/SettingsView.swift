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
            Background(userDelegate.theme) {
                
                VStack(alignment: .trailing) {
                    header()
                    List {
                        
                        NavigationLink {
                            ThemePickerView()
                                .environmentObject(userDelegate)
                        } label: {
                            WPText("Select Theme", userDelegate.theme)
                                .padding()
                                
                        }
                        .listRowBackground(userDelegate.theme.weatherBackground)

                        
                        WPText("Select Theme", userDelegate.theme)
                            .listRowBackground(userDelegate.theme.weatherBackground)
                            .padding()
                        
                        WPText("Saved Locations", userDelegate.theme)
                            .listRowBackground(userDelegate.theme.weatherBackground)
                            .padding()
                        
                        WPText("Temperature Measurement", userDelegate.theme)
                            .listRowBackground(userDelegate.theme.weatherBackground)
                            .padding()
                            
                    }
                    
                    
//                    .background(userDelegate.theme.backgroundColor)
                    
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
