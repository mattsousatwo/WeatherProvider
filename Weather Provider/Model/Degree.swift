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
//        let rounded = inputValue.rounded()
        self.asString = "\(inputValue)" + "°"
        self.asInt = inputValue
        self.asCGFloat = CGFloat(inputValue)
    }
    
    init(_ inputValue: Double) {
        let rounded = inputValue.rounded()
        let roundedWithoutDecimal = String(format: "%.0f", rounded)
        self.asString = "\(roundedWithoutDecimal)" + "°"
        self.asInt = Int(rounded)
        self.asCGFloat = CGFloat(rounded)
    }

}
