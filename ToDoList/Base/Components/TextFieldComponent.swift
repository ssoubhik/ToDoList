//
//  TextFieldComponent.swift
//  ToDoList
//
//  Created by Soubhik Sarkhel on 29/11/24.
//

import SwiftUI

// MARK: - Focus Field Cases

enum FocusedField {
    case firstName, lastName
    case email, password, confirmPassword
    case title, description
}

// MARK: - TextField Component

struct TextFieldComponent: View {
    enum CustomTextFieldStyle {
        case plain
        case header
    }

    // focus state
    @FocusState var focusedField: FocusedField?

    // data binding
    @Binding var text: String

    let placeholder: String
    let focus: FocusedField
    let style: CustomTextFieldStyle

    internal init(
        focusedField: FocusState<FocusedField?>,
        text: Binding<String>,
        placeholder: String,
        icon: String = "",
        focus: FocusedField,
        style: CustomTextFieldStyle = .header
    ) {
        _focusedField = focusedField
        _text = text
        self.placeholder = placeholder
        self.focus = focus
        self.style = style
    }

    var body: some View {
        switch style {
        case .plain:
            TextFieldWrapper(
                focusedField: _focusedField,
                text: $text,
                placeholder: placeholder,
                focus: focus
            )
            .textFieldBackground(isFocused: focusedField == focus)
        case .header:
            VStack(alignment: .leading) {
                TextComponent(
                    text: placeholder,
                    fontWeight: .bold
                )

                TextFieldWrapper(
                    focusedField: _focusedField,
                    text: $text,
                    placeholder: placeholder,
                    focus: focus
                )
                .textFieldBackground(isFocused: focusedField == focus)
            }
        }
    }
}

// MARK: - TextField Wrapper

struct TextFieldWrapper: View {
    @FocusState var focusedField: FocusedField?
    @Binding var text: String

    let placeholder: String
    let focus: FocusedField

    var body: some View {
        if focus == .password || focus == .confirmPassword {
            SecureField(placeholder, text: $text)
                .font(.system(size: 14, weight: .regular))
                .focused($focusedField, equals: focus)
                .autocorrectionDisabled()
                .keyboardType(getKeyboardType())
                .textInputAutocapitalization(getAutoCapitalizationType())
                .textContentType(getContentType())
        } else {
            TextField(placeholder, text: $text)
                .font(.system(size: 14, weight: .regular))
                .focused($focusedField, equals: focus)
                .autocorrectionDisabled()
                .keyboardType(getKeyboardType())
                .textInputAutocapitalization(getAutoCapitalizationType())
                .textContentType(getContentType())
        }
    }

    // Method: use numberpad keyboard type
    func getKeyboardType() -> UIKeyboardType {
        switch focus {
        case .email:
            return .emailAddress
        default:
            return .default
        }
    }

    // Method: auto capitalization type
    func getAutoCapitalizationType() -> TextInputAutocapitalization {
        switch focus {
        case .email:
            return .never
        default:
            return .sentences
        }
    }

    // Method: get content type
    func getContentType() -> UITextContentType? {
        switch focus {
        case .email:
            return .emailAddress
        default:
            return .none
        }
    }
}

// MARK: - Background Modifiers for Text Field component

struct TextFieldBackgroundModifier: ViewModifier {
    var isFocused: Bool

    func body(content: Content) -> some View {
        content
            .padding(18)
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(isFocused ? .accentColor : Color.secondary)
                    }
            }
    }
}
