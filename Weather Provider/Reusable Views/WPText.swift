//
//  WPText.swift
//  Weather Provider
//
//  Created by Matthew Sousa on 5/18/23.
//

import SwiftUI

/// Text View to be used instead of Text for the Weather Provider App
struct WPText: View {
    
    /// Initalizer for WPText - sets the string variable
    init(_ text: String) {
        self.textString = text
    }
    /// String property for the Text View 
    private let textString: String
    
    var body: some View {
        Text(textString)
            .fontDesign(.rounded)
            .fontWeight(.light)
            .foregroundColor(Color("TextColor"))
    }
}

struct WPText_Previews: PreviewProvider {
    static var previews: some View {
        Background {
            VStack {
                WPText("**Regular Text**")
            
                
                WPText("Large Title")
                    .font(.largeTitle)
                WPText("Title")
                    .font(.title)
                WPText("Headline")
                    .font(.headline)
                
                
            }
            .padding()
        }
    }
}
