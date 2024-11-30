//
//  LoadingView.swift
//  ToDoList
//
//  Created by Soubhik Sarkhel on 29/11/24.
//

import SwiftUI

// MARK: - Loading View

struct LoadingView: View {
    var body: some View {
        ZStack {
            // dimmed background
            Color.black.opacity(0.3)
                .ignoresSafeArea()
            
            VStack {
                // loader
                ProgressView()
                    .progressViewStyle(.circular)
                    .scaleEffect(2)
                    .padding()
                
                // loading text
                TextComponent(
                    text: StaticText.loading,
                    fontWeight: .bold,
                    fontSize: 18,
                    fontColor: .secondary
                )
                .padding(.horizontal, 10)
            }
            .padding()
            .background(.white)
            .cornerRadius(10)
        }
    }
}

#Preview {
    LoadingView()
}
