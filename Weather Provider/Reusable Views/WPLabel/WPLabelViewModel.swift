//
//  WPLabelViewModel.swift
//  Weather Provider
//
//  Created by Matthew Sousa on 5/18/23.
//

import Foundation
import SwiftUI

/// View Model for the WPLabel
struct WPLabelViewModel: WPViewModel {
    let title: String
    let text: String
    let imageName: String
    
    func mainBody(_ theme: Theme) -> some View {
        viewStructure(theme)
    }
    
    /// Structure of the view
    func viewStructure(_ theme: Theme) -> some View {
        HStack {
            icon(theme.textColor)
            textView(theme.textColor)
        }
        
    }
    
}

// Views
extension WPLabelViewModel {
    
    /// A text view with a bold title in the first line of the text view
    private func textView(_ color: Color) -> some View {
        Group {
            Text(title)
                .fontWeight(.bold) +
            Text(": " + text)
                .fontWeight(.light)
        }
            .foregroundColor(color)
            .fontDesign(.rounded)
    }
    
    /// Icon for the label
    private func icon(_ color: Color) -> some View {
        return Image(systemName: imageName)
            .resizable()
            .foregroundColor(color)
            .aspectRatio(contentMode: .fit)
            .frame(width: 25, height: 25)
            
    }
}

