//
//  WPButton.swift
//  Weather Provider
//
//  Created by Matthew Sousa on 5/18/23.
//

import SwiftUI

/// Creates a button that displays a custom label.
///
/// - Parameters:
///   - text: The text that describes the purpose of the button's `action`
///   - action: The buttons functionality
struct WPButton: View {
    let text: String
    let accent: Color
    let textColor: Color
    let action: () -> Void
    
    
    public init(_ text: String, accent: Color = Color("Accent"), textColor: Color = Color("TextColor"), action: @escaping () -> Void) {
        self.text = text
        self.accent = accent
        self.textColor = textColor
        self.action = action
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(text)
                .fontWeight(.medium)
                .foregroundColor(textColor)
                .padding()
                .frame(width: 225)
                .background(accent)
                .cornerRadius(12)
        }
        .buttonStyle(PlainButtonStyle() )
    }
    
}

struct WPButton_Previews: PreviewProvider {
    static var previews: some View {
        WPButton("Button 1") {
            print("Hello, World!")
        }
    }
}


