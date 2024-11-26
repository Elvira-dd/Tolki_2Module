//
//  SettingView.swift
//  Tolki
//
//  Created by Эльвира on 12.11.2024.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @State private var showFeedback = false
    @State private var showAbout = false

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Select Theme")) {
                    ThemeSelectionRow(themeName: "Light", isSelected: themeManager.selectedTheme == "light") {
                        themeManager.selectedTheme = "light"
                    }
                    ThemeSelectionRow(themeName: "Dark", isSelected: themeManager.selectedTheme == "dark") {
                        themeManager.selectedTheme = "dark"
                    }
                    ThemeSelectionRow(themeName: "Blue", isSelected: themeManager.selectedTheme == "blue") {
                        themeManager.selectedTheme = "blue"
                    }
                }
                
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
            }
            .navigationBarTitle("Settings")
        }
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
