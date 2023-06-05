//
//  WPViewModel.swift
//  Weather Provider
//
//  Created by Matthew Sousa on 5/18/23.
//

import Foundation
import SwiftUI

/// Protocol indicating all of the views a viewModel should have
public protocol WPViewModel {
    associatedtype MainBodyView: View
    associatedtype StructureView: View
    
    /// Main View used to display the body of the view
    func mainBody(_ theme: Theme) -> MainBodyView
    func viewStructure(_ theme: Theme) -> StructureView
}
