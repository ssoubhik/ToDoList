//
//  ToDoListApp.swift
//  ToDoList
//
//  Created by Soubhik Sarkhel on 29/11/24.
//

import SwiftUI

@main
struct ToDoListApp: App {
    // register app delegate
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    // state obejct
    @StateObject private var sessionVM = SessionViewModelImpl()

    var body: some Scene {
        WindowGroup {
            RootView()
                .preferredColorScheme(.light)
                .environmentObject(sessionVM)
        }
    }
}
