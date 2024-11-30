//
//  ValidationError.swift
//  ToDoList
//
//  Created by Soubhik Sarkhel on 29/11/24.
//

import Foundation

// MARK: - Validation Error

enum ValidationError: LocalizedError {
    case missingFirstName, missingLastName
    case missingEmail
    case invalidEmail
    case missingPassword, passwordDontMatch

    var errorDescription: String? {
        switch self {
        case .missingFirstName:
            return StaticText.missingFirstName
        case .missingLastName:
            return StaticText.missingLastName
        case .missingEmail:
            return StaticText.missingEmail
        case .invalidEmail:
            return StaticText.invalidEmail
        case .missingPassword:
            return StaticText.missingPassword
        case .passwordDontMatch:
            return StaticText.passwordDontMatch
        }
    }
}
