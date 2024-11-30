//
//  StringExt.swift
//  ToDoList
//
//  Created by Soubhik Sarkhel on 29/11/24.
//

import SwiftUI

// MARK: - String Extension

extension String {
    // check for blank string
    var isBlank: Bool {
      return allSatisfy({ $0.isWhitespace })
    }

    // check valid email
    var isValidEmail: Bool {
        NSPredicate(format: RegexConstants.format, RegexConstants.email).evaluate(with: self)
    }

    // check strong password
    var isStrongPassword: Bool {
        NSPredicate(format: RegexConstants.format, RegexConstants.strongPassword).evaluate(with: self)
    }

    // check phone number
    var isValidPhoneNo: Bool {
        NSPredicate(format: RegexConstants.format, RegexConstants.phoneNumber).evaluate(with: self)
    }
    
    func formatDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = "yyyy-MM-dd"
            return dateFormatter.string(from: date)
        } else {
            return ""
        }
    }
}
