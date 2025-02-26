//
//  SettingsView.swift
//  Tolki
//
//  Created by Эльвира on 12.11.2024.
//

import SwiftUI

struct SettingsView: View {
    @State private var showFeedback = false
    @State private var showAbout = false

    var body: some View {
        VStack {
            Text("Настройки")
                .font(.largeTitle)
                .bold()
                .padding()

            Section(header: Text("Information")) {
                Button(action: { showFeedback.toggle() }) {
                    Text("Feedback")
                }
                .sheet(isPresented: $showFeedback) {
                    FeedbackView()
                }
                
                Button(action: { showAbout.toggle() }) {
                    Text("About")
                }
                .sheet(isPresented: $showAbout) {
                    AboutView()
                }
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground)) // Используем стандартный цвет фона
    }
}

struct ThemeSelectionRow: View {
    let themeName: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        HStack {
            Text(themeName)
            Spacer()
            if isSelected {
                Image(systemName: "checkmark").foregroundColor(.blue)
            }
        }
        .contentShape(Rectangle())
        .onTapGesture(perform: action)
    }
}

#Preview {
    SettingsView()
}
