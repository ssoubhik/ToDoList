//
//  TodoDetailsView.swift
//  ToDoList
//
//  Created by Soubhik Sarkhel on 30/11/24.
//

import SwiftUI

struct TodoDetailView: View {
    @ObservedObject var viewModel: TodoViewModelImpl

    let todo: TodoItem

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // title
                TextComponent(
                    text: "\(StaticText.title):",
                    fontWeight: .semibold,
                    fontSize: 18
                )
                TextComponent(text: todo.title)

                // description
                TextComponent(
                    text: "\(StaticText.description):",
                    fontWeight: .semibold,
                    fontSize: 18
                )
                TextComponent(text: todo.taskDescription)

                // due date
                TextComponent(
                    text: "\(StaticText.dueDate):",
                    fontWeight: .semibold,
                    fontSize: 18
                )
                TextComponent(text: todo.dueDate.formatDate())

                // priority
                TextComponent(
                    text: "\(StaticText.priority):",
                    fontWeight: .semibold,
                    fontSize: 18
                )
                TextComponent(
                    text: todo.priority.capitalized,
                    fontColor: priorityColor(for: TodoPriority(from: todo.priority))
                )

                // status
                TextComponent(
                    text: "\(StaticText.status):",
                    fontWeight: .semibold,
                    fontSize: 18
                )
                TextComponent(
                    text: todo.isComplete ? StaticText.complete : StaticText.incomplete,
                    fontColor: todo.isComplete ? .green : .red
                )

                HStack { Spacer() }
            }
            .padding()
        }
        .navigationTitle(StaticText.taskDetails)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                // edit button: navigates to edit todo vieew
                NavigationLink {
                    EditTodoView(viewModel: viewModel, todo: todo)
                } label: {
                    TextComponent(text: StaticText.edit)
                }
            }
        }
    }

    // Function to get the font color based on priority
    func priorityColor(for priority: TodoPriority) -> Color {
        switch priority {
        case .high:
            return .red  // Red for high priority
        case .medium:
            return .orange  // Orange for medium priority
        case .low:
            return .blue  // Blue for low priority
        }
    }
}
