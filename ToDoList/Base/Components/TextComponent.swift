//
//  TextComponent.swift
//  ToDoList
//
//  Created by Soubhik Sarkhel on 29/11/24.
//

import SwiftUI

// MARK: - Text Component

struct TextComponent: View {
    let text: String
    let fontWeight: Font.Weight
    let fontSize: CGFloat
    let fontColor: Color
    let alignment: TextAlignment
    let lineLimit: Int

    internal init(
        text: String,
        fontWeight: Font.Weight = .regular,
        fontSize: CGFloat = 16,
        fontColor: Color = .black,
        alignment: TextAlignment = .leading,
        lineLimit: Int = 0
    ) {
        self.text = text
        self.fontWeight = fontWeight
        self.fontSize = fontSize
        self.fontColor = fontColor
        self.alignment = alignment
        self.lineLimit = lineLimit
    }

    var body: some View {
        if lineLimit > 0 {
            Text(text)
                .font(.system(size: fontSize, weight: fontWeight))
                .foregroundColor(fontColor)
                .multilineTextAlignment(alignment)
                .lineLimit(lineLimit)
        } else {
            Text(text)
                .font(.system(size: fontSize, weight: fontWeight))
                .foregroundColor(fontColor)
                .multilineTextAlignment(alignment)
        }
    }
}
