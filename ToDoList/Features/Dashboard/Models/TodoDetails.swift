//
//  TodoDetails.swift
//  ToDoList
//
//  Created by Soubhik Sarkhel on 30/11/24.
//

import Foundation

// MARK: - To-Do Details Model

struct TodoDetails {
    var title: String = ""
    var description: String = ""
    var priority: String
    var dueDate: Date
}

// MARK: - To-Do Details Extension

extension TodoDetails {
    static var new: TodoDetails {
        TodoDetails(
            title: "",
            description: "",
            priority: TodoPriority.medium.key,
            dueDate: Date()
        )
    }
}
