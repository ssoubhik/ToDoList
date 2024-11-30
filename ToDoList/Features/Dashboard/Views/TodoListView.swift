//
//  TodoListView.swift
//  ToDoList
//
//  Created by Soubhik Sarkhel on 30/11/24.
//

import SwiftUI
import RealmSwift

// MARK: - To-Do List View

struct TodoListView: View {
    @StateObject private var viewModel = TodoViewModelImpl()

    @ObservedResults(TodoItem.self) var todos

    @State private var showAddTodoModal: Bool = false

    var body: some View {
        NavigationView {
            ZStack {
                // List of tasks
                List {
                    ForEach(todos) { todo in
                        if todo.isActive {
                            TodoListRow(viewModel: viewModel, todo: todo)
                        }
                    }
                    .onDelete(perform: deleteTodo)
                }

                // floating plus button: on click open add new todo heet
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            showAddTodoModal = true
                        }) {
                            Image(systemName: StaticImage.plus)
                                .font(.system(size: 24))
                                .frame(width: 60, height: 60)
                                .foregroundColor(.white)
                                .background(Color.blue)
                                .cornerRadius(30)
                                .shadow(radius: 4)
                        }
                        .padding()
                        .sheet(isPresented: $showAddTodoModal) {
                            AddTodoView(viewModel: viewModel)
                        }
                    }
                }
            }
            .navigationTitle(StaticText.todoList)
        }
        .navigationViewStyle(.stack)
    }

    // Delete a task
    private func deleteTodo(at offsets: IndexSet) {
        for index in offsets {
            viewModel.deleteTodo(todo: viewModel.todos[index])
        }
    }
}

// MARK: - To Do List Row

struct TodoListRow: View {
    @ObservedObject var viewModel: TodoViewModelImpl

    let todo: TodoItem

    var body: some View {
        HStack(alignment: .top) {
            // checkmark button: mark tasks as completed
            Button {
                updateTodo()
            } label: {
                Image(systemName: todo.isComplete ? StaticImage.checkedCircle : StaticImage.circle)
                    .foregroundColor(todo.isComplete ? .green : .gray)
            }
            .buttonStyle(PlainButtonStyle())
            .padding(.top, 4)

            // navigate to detail view on click 
            NavigationLink {
                TodoDetailView(viewModel: viewModel, todo: todo)
            } label: {
                VStack(alignment: .leading) {
                    Text(todo.title)
                        .strikethrough(todo.isComplete, color: .gray)
                        .foregroundColor(todo.isComplete ? .gray : .black)

                    Text(todo.taskDescription)
                        .strikethrough(todo.isComplete, color: .gray)
                        .foregroundColor(.secondary)
                }
            }
            .disabled(todo.isComplete)
        }
    }

    func updateTodo() {
        let updatedTodo = TodoDetails(
            title: todo.title,
            description: todo.taskDescription,
            priority: todo.priority,
            dueDate: todo.dueDate
        )

        viewModel.updateTodo(
            todo: todo,
            todoDetails: updatedTodo,
            isComplete: !todo.isComplete
        )
    }
}

#Preview {
    TodoListView()
}
