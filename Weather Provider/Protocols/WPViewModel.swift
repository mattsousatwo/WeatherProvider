//
//  WPViewModel.swift
//  Weather Provider
//
//  Created by Matthew Sousa on 5/18/23.
//

import Foundation
import SwiftUI

/// Protocol indicating all of the views a viewModel should have
protocol WPViewModel {
    associatedtype swiftUIView = View
    
    /// Main View used to display the body of the view
    func mainBody() -> swiftUIView
    
    
} 




