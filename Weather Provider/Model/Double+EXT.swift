//
//  Double+EXT.swift
//  Weather Provider
//
//  Created by Matthew Sousa on 12/17/23.
//

import Foundation

extension Double {
    
    /// Returns a String with the value of the Double rounded to only use the frist two decimal points 
    var roundByTwoDigits: String {
        return  String(format: "%.2f", self)
    }
}
