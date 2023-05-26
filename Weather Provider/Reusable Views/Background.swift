//
//  Background.swift
//  Weather Provider
//
//  Created by Matthew Sousa on 5/17/23.
//

import SwiftUI

/// Background is a ZStack with the background color embedded inside it 
struct Background<Content: View>: View {
    @ViewBuilder var content: Content
    let theme: Theme
    
    init(_ theme: Theme = ThemeList.one.theme, @ViewBuilder content: () -> Content) {
        self.theme = theme
        self.content = content()
    }
    
    var body: some View {
        ZStack() {
            theme.backgroundColor
                .ignoresSafeArea(.all)
            content
        }
    }
}

struct Background_Previews: PreviewProvider {
    static var previews: some View {
        Background {
            Text("Hello, World")
        }
    }
}
