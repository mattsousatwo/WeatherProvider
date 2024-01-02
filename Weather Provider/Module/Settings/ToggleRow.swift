//
//  ToggleRow.swift
//  Weather Provider
//
//  Created by Matthew Sousa on 12/24/23.
//

import SwiftUI

struct ToggleRow: View {
    @EnvironmentObject var userDelegate: UserDelegate
    
    let title: String
    let action: () -> Void
    @State private var toggle: Bool = true
    
    init(_ title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }
    
    // MARK: For Preview Purposes Only
    init(toggle: Bool, action: @escaping () -> Void) {
        self.title = "title"
        self.toggle = toggle
        self.action = action
    }

    var body: some View {
        
        HStack {
            WPText(title, userDelegate.theme)
            Spacer()
            Toggle("", isOn: $toggle)
                .labelsHidden()
                .tint(userDelegate.theme.weatherBackground)
        }
        
        .padding()
    }
    
}

#Preview {
    let theme = UserDelegate()
    theme.theme = ThemeList.four.theme
    
    return Background(displayType: .one, theme.theme, content: {
        VStack {
            ToggleRow(toggle: true) {
                
            }
            ToggleRow(toggle: false) {
                
            }
        }
    })
    .environmentObject(theme )
}
