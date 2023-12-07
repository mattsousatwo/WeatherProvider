//
//  LoadingClass.swift
//  Weather Provider
//
//  Created by Matthew Sousa on 12/7/23.
//

import Foundation

/// Loading Class is used to handle the common methods when loading data through the FileManager 
public class LoadingClass {
    
    let decoder = JSONDecoder()
    let encoder = JSONEncoder()
    let fileManager = FileManager.default
    
    init() {
        encoder.outputFormatting = .prettyPrinted
    }
    
}


extension LoadingClass {
    
    /// Method to check if a selected directory is already saved to disk 
    func checkIfDirectoryExists(for directoryName: WPKeychain) -> Bool {
        var filePath = ""
        let directories = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory,
                                                              FileManager.SearchPathDomainMask.allDomainsMask,
                                                              true)
        if directories.count > 0 {
            let dir = directories[0]
            filePath = dir.description.appendingFormat("/", "\(directoryName.rawValue).json")
            print("Local path for \(directoryName) - \(filePath)/n")
        } else {
            print("Could not find path for \(directoryName.rawValue)")
            return false
        }
        
        if fileManager.fileExists(atPath: filePath) {
            print("\(directoryName.rawValue) found")
            return true
        } else {
            print("\(directoryName.rawValue) was not found ")
            return false
        }
    }
    
    
}
