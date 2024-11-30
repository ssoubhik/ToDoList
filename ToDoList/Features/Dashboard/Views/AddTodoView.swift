//
//  AddTodoView.swift
//  ToDoList
//
//  Created by Soubhik Sarkhel on 30/11/24.
//

import SwiftUI

// MARK: - Add To-Do View

struct AddTodoView: View {
    // environment object
    @Environment(\.dismiss) var dismiss

    // focus state
    @FocusState var focusedField: FocusedField?

    // viewmodel object
    @ObservedObject var viewModel: TodoViewModelImpl

    // state property
    @State private var newToDo = TodoDetails.new

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // title textfield
                    TextFieldComponent(
                        focusedField: _focusedField,
                        text: $newToDo.title,
                        placeholder: StaticText.title,
                        focus: .title
                    )

                    // description textfield
                    TextFieldComponent(
                        focusedField: _focusedField,
                        text: $newToDo.description,
                        placeholder: StaticText.description,
                        focus: .description
                    )

                    // due date picker
                    DueDatePicker(dueDate: $newToDo.dueDate)

                    // priority menu picker
                    PriorityPickerView(priority: $newToDo.priority)
                    
                    // add task button
                    Button {
                        addTodo()
                    } label: {
                        ButtonComponent(title: StaticText.addTask)
                    }
                    .padding(.top)
                }
                .padding()
            }
            .navigationTitle(StaticText.newTask)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(StaticText.cancel) {
                        dismiss()
                    }
                }
            }
        }
    }

    // Method: add todo item
    private func addTodo() {
        focusedField = nil
        viewModel.addTodo(todoDetails: newToDo)
        dismiss()
    }
}


// MARK: - Due Date Picker View

struct DueDatePicker: View {
    @Binding var dueDate: Date

    var body: some View {
        VStack(alignment: .leading) {
            TextComponent(
                text: StaticText.dueDate,
                fontWeight: .bold
            )

            DatePicker("", selection: $dueDate, in: Date()..., displayedComponents: .date)
                .labelsHidden()

            HStack { Spacer() }
        }
    }
}


// MARK: - Priority Picker View

struct PriorityPickerView: View {
    @Binding var priority: String

    var body: some View {
        VStack(alignment: .leading) {
            TextComponent(
                text: StaticText.priority,
                fontWeight: .bold
            )

            // Menu Picker to select an option
            Menu {
                // Define the options in the Menu
                ForEach(TodoPriority.allCases, id: \.self) { option in
                    Button(option.key.capitalized) {
                        // Update selectedOption when an option is selected
                        priority = option.key
                    }
                }
            } label: {
                // Button style for the Menu label
                Image(systemName: StaticImage.updownArrow)
                    .foregroundColor(.accentColor)

                TextComponent(
                    text: priority.capitalized,
                    fontColor: .accentColor
                )
            }

            HStack { Spacer() }
        }
    }
}
