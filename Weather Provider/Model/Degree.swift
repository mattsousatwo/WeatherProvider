//
//  Degree.swift
//  Weather Provider
//
//  Created by Matthew Sousa on 6/7/23.
//

import Foundation

struct Degree {
    
    let asString: String
    let asInt: Int
    
    init(_ inputValue: Int) {
        self.asString = "\(inputValue)" + "°"
        self.asInt = inputValue
    }
}
