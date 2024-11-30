//
//  TodoViewModel.swift
//  ToDoList
//
//  Created by Soubhik Sarkhel on 30/11/24.
//

import SwiftUI
import RealmSwift
import FirebaseFirestore

// MARK: - To-Do View Model Protocol

protocol TodoViewModel {
    func fetchTodosFromRealm()
    func fetchTodos()
    func addTodo(todoDetails: TodoDetails)
    func deleteTodo(todo: TodoItem)
    func updateTodo(todo: TodoItem, todoDetails: TodoDetails, isComplete: Bool)
}

// MARK: - To-Do View Model Implementation

class TodoViewModelImpl: ObservableObject, TodoViewModel {
    @AppStorage(StorageKeys.firebaseUID) var firebaseUID = ""

    @Published var todos: [TodoItem] = []

    init() {
        fetchTodos()
        NotificationCenter.default.addObserver(self, selector: #selector(syncTodosWithFirestore), name: .networkAvailable, object: nil)
        startPeriodicSync()
    }

    // Method: fetch todo list from realm db
    func fetchTodosFromRealm() {
        do {
            let realm = try Realm()
            let results = realm.objects(TodoItem.self)
            todos = Array(results)
        } catch {
            print("Failed to initialize Realm: \(error.localizedDescription)")
        }
    }

    // Method: fetch todo list from firestore and update realm db
    func fetchTodos() {
        // Check if network is available then fetch from firestore otherwise show todo list from realm db only
        if NetworkMonitor.shared.isConnected {
            FirebaseManager.shared.firestore?
                .collection(FirestoreCollection.todos.key)
                .whereField(FirestoreUser.uid.key, isEqualTo: firebaseUID)
                .order(by: FirestoreTodoItem.createdAt.key)
                .getDocuments { [weak self] snapshot, error in
                    guard let self = self else { return }

                    if error != nil {
                        self.fetchTodosFromRealm()
                        return
                    }

                    guard let documents = snapshot?.documents else {
                        self.fetchTodosFromRealm()
                        return
                    }

                    do {
                        let realm = try Realm()
                        try realm.write {
                            for document in documents {
                                let data = document.data()
                                // Check if the TodoItem already exists in Realm
                                if let todo = realm.object(ofType: TodoItem.self, forPrimaryKey: document.documentID) {
                                    // If it exists, just update the fields
                                    todo.title = data[FirestoreTodoItem.title.key] as? String ?? ""
                                    todo.taskDescription = data[FirestoreTodoItem.taskDescription.key] as? String ?? ""
                                    todo.isComplete = data[FirestoreTodoItem.isComplete.key] as? Bool ?? false
                                    todo.isActive = data[FirestoreTodoItem.isActive.key] as? Bool ?? true
                                    todo.createdDate = data[FirestoreTodoItem.createdAt.key] as? Date ?? Date()
                                    todo.isSynced = true
                                } else {
                                    // If it's a new object, create a new TodoItem and set its id
                                    let newTodo = TodoItem()
                                    newTodo.id = document.documentID // Set the primary key here
                                    newTodo.title = data[FirestoreTodoItem.title.key] as? String ?? ""
                                    newTodo.taskDescription = data[FirestoreTodoItem.taskDescription.key] as? String ?? ""
                                    newTodo.isComplete = data[FirestoreTodoItem.isComplete.key] as? Bool ?? false
                                    newTodo.isActive = data[FirestoreTodoItem.isActive.key] as? Bool ?? true
                                    newTodo.createdDate = data[FirestoreTodoItem.createdAt.key] as? Date ?? Date()
                                    newTodo.isSynced = true
                                    realm.add(newTodo, update: .modified)
                                }
                            }
                        }
                        self.fetchTodosFromRealm()
                    } catch {
                        self.fetchTodosFromRealm()
                    }
                }
        } else {
            fetchTodosFromRealm()
        }
    }

    // Method: add todo item in realm db and sync to firestore
    func addTodo(todoDetails: TodoDetails) {
        let newTodo = TodoItem()
        newTodo.title = todoDetails.title
        newTodo.taskDescription = todoDetails.description
        newTodo.dueDate = todoDetails.dueDate
        newTodo.priority = todoDetails.priority
        newTodo.isSynced = false

        do {
            let realm = try Realm()
            try realm.write {
                realm.add(newTodo)
            }
            fetchTodosFromRealm()
            syncTodosWithFirestore()
        } catch {
            print("Failed to add todo: \(error.localizedDescription)")
        }
    }

    // Method: delete todo item from realm db and sync to firestore
    func deleteTodo(todo: TodoItem) {
        do {
            let realm = try Realm()
            guard let object = realm.object(ofType: TodoItem.self, forPrimaryKey: todo.id) else { return }
            try realm.write {
                object.isActive = false
                object.isSynced = false
            }
            fetchTodosFromRealm()
            syncTodosWithFirestore()
        } catch {
            print("Failed to delete todo: \(error.localizedDescription)")
        }
    }

    // Method: update todo item in realm db and sync to firestore
    func updateTodo(todo: TodoItem, todoDetails: TodoDetails, isComplete: Bool) {
        do {
            let realm = try Realm()
            guard let object = realm.object(ofType: TodoItem.self, forPrimaryKey: todo.id) else { return }
            try realm.write {
                object.title = todoDetails.title
                object.taskDescription = todoDetails.description
                object.dueDate = todoDetails.dueDate
                object.priority = todoDetails.priority
                object.isComplete = isComplete
                object.isSynced = false
            }
            fetchTodosFromRealm()
            syncTodosWithFirestore()
        } catch {
            print("Failed to update todo: \(error.localizedDescription)")
        }
    }

    // Method: sync todo item to firestore
    @objc func syncTodosWithFirestore() {
        do {
            let realm = try Realm()
            let unsyncedTodos = realm.objects(TodoItem.self).filter("isSynced == false")

            for todo in unsyncedTodos {
                let todoData: [String: Any] = [
                    FirestoreTodoItem.title.key: todo.title,
                    FirestoreTodoItem.taskDescription.key: todo.taskDescription,
                    FirestoreTodoItem.isComplete.key: todo.isComplete,
                    FirestoreTodoItem.isActive.key: todo.isActive,
                    FirestoreTodoItem.createdAt.key: todo.createdDate,
                    FirestoreTodoItem.dueDate.key: todo.dueDate,
                    FirestoreTodoItem.priority.key: todo.priority,
                    FirestoreTodoItem.uid.key: firebaseUID
                ]

                FirebaseManager.shared.firestore?.collection(FirestoreCollection.todos.key).document(todo.id).setData(todoData) { _ in
                    do {
                        try realm.write {
                            todo.isSynced = true
                        }
                    } catch {
                        print("Failed to update isSynced status for \(todo.id): \(error.localizedDescription)")
                    }
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }

    // Start periodic syncing
    private func startPeriodicSync() {
        Timer.scheduledTimer(withTimeInterval: 60.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if NetworkMonitor.shared.isConnected {
                self.syncTodosWithFirestore()
            }
        }
    }
}
