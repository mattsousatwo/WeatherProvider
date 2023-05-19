//
//  WPLabel.swift
//  Weather Provider
//
//  Created by Matthew Sousa on 5/18/23.
//

import SwiftUI

/// Label to display a message accompanied by an icon 
struct WPLabel: View {
    let title: String
    let text: String
    let imageName: String
    let viewModel: WPLabelViewModel
    init(title: String, text: String, imageName: String) {
        self.title = title
        self.text = text
        self.imageName = imageName
        viewModel = WPLabelViewModel(title: title,
                                     text: text,
                                     imageName: imageName)
    }
    
    var body: some View {
        viewModel.mainBody()
    }
}

struct WPLabel_Previews: PreviewProvider {
    static var previews: some View {
        WPLabel(title: "Customizable Settings",
                text: ": You can customize the app to suit your preferences and get the weather information that matters the most to you.",
                imageName: "globe")
        .foregroundColor(Color("TextColor"))
        .fontDesign(.rounded)
        .fontWeight(.light)
    }
}
