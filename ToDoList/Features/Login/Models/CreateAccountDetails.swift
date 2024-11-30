//
//  CreateAccountDetails.swift
//  ToDoList
//
//  Created by Soubhik Sarkhel on 29/11/24.
//

import Foundation

// MARK: - Create Account Details Model

struct CreateAccountDetails {
    var firstName, lastName: String
    var email: String
    var password: String
    var confirmPassword: String
}

// MARK: - Create Account Details Extension

extension CreateAccountDetails {
    static var new: CreateAccountDetails {
        CreateAccountDetails(
            firstName: "",
            lastName: "",
            email: "",
            password: "",
            confirmPassword: ""
        )
    }
}
