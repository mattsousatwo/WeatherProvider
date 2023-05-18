//
//  Background.swift
//  Weather Provider
//
//  Created by Matthew Sousa on 5/17/23.
//

import SwiftUI

/// Background is a ZStack with the background color embedded inside it 
struct Background<Content: View>: View {
    @ViewBuilder var someView: Content
    
    var body: some View {
        ZStack() {
            Color("Background")
                .ignoresSafeArea(.all)
            someView
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
