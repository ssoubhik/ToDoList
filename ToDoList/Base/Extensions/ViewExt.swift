//
//  ViewExt.swift
//  ToDoList
//
//  Created by Soubhik Sarkhel on 29/11/24.
//

import SwiftUI

extension View {
    func textFieldBackground(isFocused: Bool) -> some View {
        self.modifier(TextFieldBackgroundModifier(isFocused: isFocused))
    }
}
