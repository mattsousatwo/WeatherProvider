//
//  HomeView.swift
//  Weather Provider
//
//  Created by Matthew Sousa on 5/17/23.
//

import SwiftUI

/// Home view is used to display all the main weather information
struct HomeView: View {
    
    /// View Model for the Home Module
    let viewModel = HomeViewModel()
    
    var body: some View {
        
        viewModel.mainBody()
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
