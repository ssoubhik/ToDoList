//
//  CreateAccountView.swift
//  ToDoList
//
//  Created by Soubhik Sarkhel on 29/11/24.
//

import SwiftUI

// MARK: - Create Account View

struct CreateAccountView: View {
    // environment object
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject private var sessionVM: SessionViewModelImpl

    // focus state
    @FocusState var focusedField: FocusedField?

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // create account title
                TextComponent(
                    text: StaticText.createAccount,
                    fontSize: 25
                )
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom)

                // firstname textfield
                TextFieldComponent(
                    focusedField: _focusedField,
                    text: $sessionVM.createAccountDetails.firstName,
                    placeholder: StaticText.firstName,
                    focus: .firstName
                )

                // lastname textfield
                TextFieldComponent(
                    focusedField: _focusedField,
                    text: $sessionVM.createAccountDetails.lastName,
                    placeholder: StaticText.lastName,
                    focus: .lastName
                )

                // email textfield
                TextFieldComponent(
                    focusedField: _focusedField,
                    text: $sessionVM.createAccountDetails.email,
                    placeholder: StaticText.email,
                    focus: .email
                )

                // password textfield
                TextFieldComponent(
                    focusedField: _focusedField,
                    text: $sessionVM.createAccountDetails.password,
                    placeholder: StaticText.password,
                    focus: .password
                )

                // confirm password textfield
                TextFieldComponent(
                    focusedField: _focusedField,
                    text: $sessionVM.createAccountDetails.confirmPassword,
                    placeholder: StaticText.confirmPassword,
                    focus: .confirmPassword
                )

                // register button
                Button {
                    // remove textfield focus
                    focusedField = nil

                    Task {
                        // perform account creation
                        await sessionVM.createAccount()
                    }
                } label: {
                    ButtonComponent(
                        title: StaticText.signup,
                        minWidth: 126
                    )
                }
                .padding(.top)
            }
            .padding(.vertical)
            .padding(.horizontal, 24)
        }
        .onAppear {
            sessionVM.createAccountDetails = CreateAccountDetails.new
        }
    }
}
