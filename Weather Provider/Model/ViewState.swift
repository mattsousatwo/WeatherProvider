//
//  ViewState.swift
//  Weather Provider
//
//  Created by Matthew Sousa on 12/12/23.
//

import Foundation

/// Enum to handle different states of the view life cycle 
enum ViewState: Equatable {
    case loading
    case failure(reason: String)
    case success
}
