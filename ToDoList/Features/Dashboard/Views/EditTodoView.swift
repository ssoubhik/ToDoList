//
//  EditTodoView.swift
//  ToDoList
//
//  Created by Soubhik Sarkhel on 30/11/24.
//

import SwiftUI

// MARK: - Edit To-Do View

struct EditTodoView: View {
    // environment object
    @Environment(\.dismiss) var dismiss

    // viewmodel object
    @ObservedObject var viewModel: TodoViewModelImpl

    // focus state
    @FocusState var focusedField: FocusedField?

    // state property
    @State private var updatedToDo: TodoDetails

    let todo: TodoItem

    init(viewModel: TodoViewModelImpl, todo: TodoItem) {
        self.viewModel = viewModel
        self.todo = todo

        // Initialize the @State variable using its initial value
        _updatedToDo = State(initialValue: TodoDetails(
            title: todo.title,
            description: todo.taskDescription,
            priority: todo.priority,
            dueDate: todo.dueDate
        ))
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // title textfield
                TextFieldComponent(
                    focusedField: _focusedField,
                    text: $updatedToDo.title,
                    placeholder: StaticText.title,
                    focus: .title
                )

                // description textfield
                TextFieldComponent(
                    focusedField: _focusedField,
                    text: $updatedToDo.description,
                    placeholder: StaticText.description,
                    focus: .description
                )

                // due date picker
                DueDatePicker(dueDate: $updatedToDo.dueDate)

                // priority menu picker
                PriorityPickerView(priority: $updatedToDo.priority)
            }
            .padding()
        }
        .navigationTitle(StaticText.editTask)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                // save button
                Button(StaticText.save) {
                    // update todo item
                    viewModel.updateTodo(
                        todo: todo,
                        todoDetails: updatedToDo,
                        isComplete: todo.isComplete
                    )

                    dismiss()
                }
            }
        }
    }
}
