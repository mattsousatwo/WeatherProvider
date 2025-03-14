//
//  SavedLocations.swift
//  Weather Provider
//
//  Created by Matthew Sousa on 12/22/23.
//

import SwiftUI

struct SavedLocations: View {
    @EnvironmentObject var userDelegate: UserDelegate
    
    var body: some View {
        Background(displayType: .two, userDelegate.theme) {
            VStack {
                header()
                List {
                    ForEach(userDelegate.savedLocations, id: \.self) { location in
                        WPText("\(location.name), \(location.region)", userDelegate.theme)
                            .padding()
                            .listRowBackground(userDelegate.theme.weatherBackground)
                    }
                    .onDelete(perform: delete)
                    .onMove(perform: move)
                }
                .shadow(radius: 2, x: 0, y: 2)
                .scrollContentBackground(.hidden)
                .tint(userDelegate.theme.weatherBackground)
                
            }
        }
        .toolbar {
            WPEditButton()
        }
        
    }
    
    func delete(at index: IndexSet) {
        userDelegate.deleteLocation(at: index)
    }
    
    func move(from source: IndexSet, to destination: Int) {
        userDelegate.savedLocations.move(fromOffsets: source, toOffset: destination)
    }
    
    /// Displays the Title
    func header() -> some View {
        HStack {
            WPOTitle("Saved Locations",
                     color: userDelegate.theme.textColor)
            .padding()
            Spacer()
        }
    }

}

#Preview {
    SavedLocations()
        .environmentObject(UserDelegate() )
}
