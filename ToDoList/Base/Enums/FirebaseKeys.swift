//
//  FirebaseKeys.swift
//  ToDoList
//
//  Created by Soubhik Sarkhel on 29/11/24.
//

import Foundation

// MARK: - Firestore Collection Keys

enum FirestoreCollection: String {
    case users
    case todos

    var key: String { self.rawValue }
}

// MARK: - Firestore User Keys

enum FirestoreUser: String {
    case firstName
    case lastName
    case email
    case uid

    var key: String { self.rawValue }
}

// MARK: - Firestore Todo Item Keys

enum FirestoreTodoItem: String {
    case title
    case taskDescription
    case isComplete
    case isActive
    case createdAt
    case dueDate
    case priority
    case uid

    var key: String { self.rawValue }
}
