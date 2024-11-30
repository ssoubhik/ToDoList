//
//  DateExt.swift
//  ToDoList
//
//  Created by Soubhik Sarkhel on 29/11/24.
//

import Foundation

extension Date {
    func formatDate() -> String {
        // Use DateFormatter to format the Date object
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.locale = Locale(identifier: "en_US")

        // Return the formatted date as a string
        return formatter.string(from: self)
    }
}
