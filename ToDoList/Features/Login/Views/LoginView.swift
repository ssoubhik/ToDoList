//
//  LoginView.swift
//  ToDoList
//
//  Created by Soubhik Sarkhel on 29/11/24.
//

import SwiftUI

// MARK: - Login View

struct LoginView: View {
    // environment object
    @EnvironmentObject private var sessionVM: SessionViewModelImpl

    // focus state
    @FocusState var focusedField: FocusedField?

    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                // signin title
                TextComponent(
                    text: StaticText.login,
                    fontSize: 25
                )
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical)

                // email textfield
                TextFieldComponent(
                    focusedField: _focusedField,
                    text: $sessionVM.loginDetails.email,
                    placeholder: StaticText.email,
                    focus: .email
                )

                // password textfield
                TextFieldComponent(
                    focusedField: _focusedField,
                    text: $sessionVM.loginDetails.password,
                    placeholder: StaticText.password,
                    focus: .password
                )

                // login button
                Button {
                    // remove textfield focus
                    focusedField = nil

                    Task {
                        // perform login
                        await sessionVM.login()
                    }
                } label: {
                    ButtonComponent(
                        title: StaticText.login,
                        minWidth: 126
                    )
                }
                .padding(.top)

                // create account button
                HStack {
                    TextComponent(text: StaticText.dontHaveAccount)

                    // navigate to create account view
                    NavigationLink {
                        CreateAccountView()
                    } label: {
                        TextComponent(
                            text: StaticText.createOne,
                            fontColor: .accentColor
                        )
                    }
                }

                Spacer()
            }
            .padding(.vertical)
            .padding(.horizontal, 24)
            .navigationTitle("")
            .onAppear {
                sessionVM.loginDetails = LoginDetails.new
            }
            .alert(StaticText.error, isPresented: $sessionVM.errorHandler.isPresented) {
                Button(role: .cancel) {
                    // no action required
                } label: {
                    TextComponent(text: StaticText.okay)
                }
            } message: {
                TextComponent(text: sessionVM.errorHandler.description)
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
        }
        .navigationViewStyle(.stack)
    }
}
