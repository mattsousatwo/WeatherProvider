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
    let asCGFloat: CGFloat
    
    init(_ inputValue: Int) {
        self.asString = "\(inputValue)" + "°"
        self.asInt = inputValue
        self.asCGFloat = CGFloat(inputValue)
    }
    
    init(_ inputValue: Double) {
        self.asString = "\(inputValue)" + "°"
        self.asInt = Int(inputValue)
        self.asCGFloat = CGFloat(inputValue)
    }

}
