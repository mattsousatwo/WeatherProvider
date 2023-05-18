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
    let action: () -> Void
    
    
    public init(_ text: String, action: @escaping () -> Void) {
        self.text = text
        self.action = action
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(text)
                .fontWeight(.medium)
//                .foregroundColor(Color("TextColor"))
                .foregroundColor(.white)
                .padding()
                .frame(width: 200)
                .background(Color("Accent"))
//                .background(Color("Background"))
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


