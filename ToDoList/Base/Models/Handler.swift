//
//  Handler.swift
//  ToDoList
//
//  Created by Soubhik Sarkhel on 29/11/24.
//

import Foundation

// MARK: - Handler Model

struct Handler {
    var isPresented: Bool = false
    var title = StaticText.error
    var description: String = ""
}
