//
//  ThemePickerView.swift
//  Weather Provider
//
//  Created by Matthew Sousa on 5/19/23.
//

import SwiftUI

/// View used to select the users desired theme
struct ThemePickerView: View {
    let viewModel = ThemePickerViewModel()
    
    var body: some View {
        viewModel.mainBody()
//        themePagePicker()
    }
}

struct ThemePickerView_Previews: PreviewProvider {
    static var previews: some View {
        ThemePickerView()
    }
}
