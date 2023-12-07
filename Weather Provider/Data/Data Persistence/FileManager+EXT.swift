//
//  FileManager+EXT.swift
//  Weather Provider
//
//  Created by Matthew Sousa on 5/17/23.
//

import Foundation

/// Extension made to provide a shortcut to the directorys location 
public extension FileManager {
    static var documentsDirectoryURL: URL {
        self.default.urls(for: .documentDirectory,
                          in: .userDomainMask)[0]
    }
}
