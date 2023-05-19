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
    
    func mainBody() -> some View {
        viewStructure()
    }
    
    /// Structure of the view
    func viewStructure() -> some View {
        HStack {
            icon()
            textView()
        }
        
    }
    
}

// Views
extension WPLabelViewModel {
    
    /// A text view with a bold title in the first line of the text view
    private func textView() -> some View {
        Group {
            Text(title)
                .fontWeight(.bold) +
            Text(": " + text)
                .fontWeight(.light)
        }
            .foregroundColor(Color("TextColor"))
            .fontDesign(.rounded)
    }
    
    /// Icon for the label
    private func icon() -> some View {
        return Image(systemName: imageName)
            .resizable()
            .foregroundColor(Color("TextColor"))
            .aspectRatio(contentMode: .fit)
            .frame(width: 25, height: 25)
            
    }
}

