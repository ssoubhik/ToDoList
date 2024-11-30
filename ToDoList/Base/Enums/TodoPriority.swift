//
//  TodoPriority.swift
//  ToDoList
//
//  Created by Soubhik Sarkhel on 30/11/24.
//

import Foundation

enum TodoPriority: String, CaseIterable {
    case high
    case medium
    case low

    var key: String { self.rawValue }

    // Initializer that takes a String and returns the corresponding TodoPriority
    init(from string: String) {
        switch string.lowercased() {
        case "high":
            self = .high
        case "medium":
            self = .medium
        case "low":
            self = .low
        default:
            self = .medium // Default to medium if the string doesn't match any case
        }
    }
}
