//
//  TodoItem.swift
//  ToDoList
//
//  Created by Soubhik Sarkhel on 30/11/24.
//

import RealmSwift
import SwiftUI

// MARK: - Todo Item Model to Store in Realm

class TodoItem: Object, Identifiable {
    @Persisted(primaryKey: true) var id: String = UUID().uuidString
    @Persisted var title: String
    @Persisted var taskDescription: String
    @Persisted var priority: String = TodoPriority.medium.key
    @Persisted var isComplete: Bool = false
    @Persisted var createdDate: Date = Date()
    @Persisted var dueDate: Date = Date()
    @Persisted var isActive: Bool = true
    @Persisted var isSynced: Bool = false
}
