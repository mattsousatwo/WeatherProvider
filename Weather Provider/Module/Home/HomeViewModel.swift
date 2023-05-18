//
//  HomeViewModel.swift
//  Weather Provider
//
//  Created by Matthew Sousa on 5/18/23.
//

import Foundation
import SwiftUI

/// Struct Containing all the views for the Home Module 
struct HomeViewModel {
    
    func homeViewBody() -> some View {
        return Background {
            
            
            
            
            
            testText()
        
            
            
            
            
            
        }
        
    }
    
    /// Background for the main view
    func testText() -> some View {
        return VStack {
            Text("Home View Model Works")
            Text("Another String")
            Text("Another String 2flksd")
            Text("Another Stringfdsfdsa")
        }
    }
    
    
    
}
