//
//  WPEditButton.swift
//  Weather Provider
//
//  Created by Matthew Sousa on 1/5/24.
//

import SwiftUI

struct WPEditButton: View {
    @Environment(\.editMode) private var editMode
    @EnvironmentObject var userDelegate: UserDelegate
    
    var body: some View {
        Button(action: {
            editMode?.wrappedValue.toggle()
        }, label: {
            WPText("Edit", userDelegate.theme)
        })
    }
}

extension EditMode {
    
    mutating func toggle() {
        self = self == .active ? .inactive : .active
    }
}

#Preview {
    WPEditButton()
}
