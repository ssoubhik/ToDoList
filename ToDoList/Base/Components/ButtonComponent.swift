//
//  ButtonComponent.swift
//  ToDoList
//
//  Created by Soubhik Sarkhel on 29/11/24.
//

import SwiftUI

// MARK: - Button Component

struct ButtonComponent: View {
    let title: String
    let fontSize: CGFloat
    let bgColor: Color
    let minWidth: CGFloat
    let minHeight: CGFloat
    let cornerRadius: CGFloat

    internal init(
        title: String,
        fontSize: CGFloat = 16,
        bgColor: Color = .accentColor,
        minWidth: CGFloat = 250,
        minHeight: CGFloat = 50,
        cornerRadius: CGFloat = 10
    ) {
        self.title = title
        self.fontSize = fontSize
        self.bgColor = bgColor
        self.minWidth = minWidth
        self.minHeight = minHeight
        self.cornerRadius = cornerRadius
    }

    var body: some View {
        TextComponent(
            text: title,
            fontWeight: .bold,
            fontSize: fontSize,
            fontColor: .white
        )
        .frame(maxWidth: minWidth, minHeight: minHeight)
        .background(bgColor, in: RoundedRectangle(cornerRadius: cornerRadius))
    }
}
