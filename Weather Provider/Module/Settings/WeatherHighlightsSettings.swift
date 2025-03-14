//
//  WeatherHighlightsSettings.swift
//  Weather Provider
//
//  Created by Matthew Sousa on 1/3/24.
//

import SwiftUI

struct WeatherHighlightsSettings: View {
    @EnvironmentObject var userDelegate: UserDelegate
    @Environment(\.dismiss) var dismiss
    
    @State private var workingHighlights: [HighlightType] = []
    var body: some View {
        Background(displayType: .two, userDelegate.theme) {
            VStack {
                header()
                List {
                    if workingHighlights.count != 0 {
                        Section {
                            ForEach(workingHighlights, id: \.id) { highlight in
                                settingsRow(for: highlight)
                            }
                            .onMove(perform: move)
                        }
                        header: {
                            WPText("Selected", userDelegate.theme)
                        }
                    }
                    
                    
                    // All Highlight Types
                    Section {
                        ForEach(HighlightType.allCases, id: \.id) { highlight in
                            settingsRow(for: highlight)
                        }
                    } header: {
                        WPText("Highlight Types", userDelegate.theme)
                    }
                }
                .shadow(radius: 2, x: 0, y: 2)
                .scrollContentBackground(.hidden)
                .tint(userDelegate.theme.weatherBackground)
                
            }
        }
        .toolbar {
            if workingHighlights.count == 3 {
                saveButton()
            }
            Spacer()
            WPEditButton()
                .environmentObject(userDelegate)
        }
        .onAppear {
            workingHighlights = userDelegate.weatherHighlights
        }
    }
    
    /// Displays the Title
    func header() -> some View {
        VStack(alignment: .leading) {
            HStack {
                WPOTitle("Weather Highlights",
                         color: userDelegate.theme.textColor)
                .padding(.horizontal)
                Spacer()
            }
            WPText("Please choose your top three highlights to save.", userDelegate.theme)
                .padding(.horizontal)
        }
        .padding(.bottom)
    }
    
    func saveButton() -> some View {
        Button(action: {
            if workingHighlights.count == 3 {
                userDelegate.weatherHighlights = workingHighlights
                userDelegate.saveHighlights()
                dismiss()
            }
        }, label: {
            WPText("Save", userDelegate.theme)
        })
    }

    func move(from source: IndexSet, to destination: Int) {
        workingHighlights.move(fromOffsets: source, toOffset: destination)
    }
    
    func settingsRow(for highlight: HighlightType) -> some View {
        
        let circleSize: CGFloat = 25
        let color = userDelegate.theme.textColor.opacity(0.9)
        
        let onButton = Circle()
            .stroke(lineWidth: 3.0)
            .frame(width: circleSize, height: circleSize)
            .foregroundStyle(color)
            .overlay {
                Circle()
                    .frame(width: (circleSize * 0.75), height: (circleSize * 0.75) )
                    .foregroundStyle(color)
                    .shadow(radius: 1, x: 0, y: 2)
            }
            .shadow(radius: 1, x: 0, y: 2)
        
        let offButton = Circle()
            .stroke(lineWidth: 3.0)
            .frame(width: circleSize, height: circleSize)
            .foregroundStyle(color)
            .shadow(radius: 1, x: 0, y: 2)
        
        var isSelected: Bool {
            if workingHighlights.contains(highlight) {
                return true
            } else {
                return false
            }
        }
        
        return HStack {
            WPText("\(highlight.name)", userDelegate.theme)
                .padding()
            
            Spacer()
            
            Button(action: {
                
                let containsHighlight = workingHighlights.contains(highlight)
                
                if workingHighlights.count < 3 {
                    switch containsHighlight {
                        case true:
                            workingHighlights.removeAll(where: { $0.id == highlight.id })
                        case false:
                            workingHighlights.append(highlight)
                    }
                } else {
                    if containsHighlight {
                        workingHighlights.removeAll(where: { $0.id == highlight.id })
                    } else {
                        workingHighlights.removeLast()
                        workingHighlights.append(highlight)
                    }
                }
            }, label: {
                if isSelected == true {
                    onButton
                } else {
                    offButton
                }
            })
            
        }
        .listRowBackground(userDelegate.theme.weatherBackground)
    }
    
    
}

#Preview {
    WeatherHighlightsSettings()
        .environmentObject(UserDelegate() )
}
