//
//  LoginDetails.swift
//  ToDoList
//
//  Created by Soubhik Sarkhel on 29/11/24.
//

import Foundation

// MARK: - Login Details Model

struct LoginDetails {
    var email: String
    var password: String
}

// MARK: - Login Details Extension

extension LoginDetails {
    static var new: LoginDetails {
        LoginDetails(
            email: "",
            password: ""
        )
    }
}
