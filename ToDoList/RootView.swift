//
//  RootView.swift
//  ToDoList
//
//  Created by Soubhik Sarkhel on 29/11/24.
//

import SwiftUI

struct RootView: View {
    // environment object
    @EnvironmentObject private var sessionVM: SessionViewModelImpl

    var body: some View {
        ZStack {
            switch sessionVM.currentFlow {
            case .landing:
                LoginView()
            case .loggedIn:
                TodoListView()
            }

            // show loader
            if sessionVM.showGlobalLoader {
                LoadingView()
            }
        }
    }
}
