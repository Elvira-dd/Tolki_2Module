//
//  SettingView.swift
//  Tolki
//
//  Created by Эльвира on 12.11.2024.
//

import SwiftUI
import Foundation

struct SettingsView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = true
    @State private var showFeedback = false
        @State private var showAbout = false
        @State private var showLogoutAlert = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Select Theme")) {
                    HStack {
                        Text("Light")
                        Spacer()
                        if themeManager.selectedTheme == "light" {
                            Image(systemName: "checkmark")
                                .foregroundColor(.blue)
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        themeManager.selectedTheme = "light"
                    }
                    HStack {
                        Text("Dark")
                        Spacer()
                        if themeManager.selectedTheme == "dark" {
                            Image(systemName: "checkmark")
                                .foregroundColor(.blue)
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        themeManager.selectedTheme = "dark"
                    }
                    HStack {
                        Text("Blue")
                        Spacer()
                        if themeManager.selectedTheme == "blue" {
                            Image(systemName: "checkmark")
                                .foregroundColor(.blue)
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        themeManager.selectedTheme = "blue"
                    }
                }
                Section(header: Text("Information")) {
                    Button(action: {
                        showFeedback.toggle()
                    }) {
                        Text("Feedback")
                    }
                    .sheet(isPresented: $showFeedback) {
                        FeedbackView()
                    }
                    Button(action: {
                        showAbout.toggle()
                    }) {
                        Text("About")
                    }
                    .sheet(isPresented: $showAbout) {
                        AboutView()
                    }
                }
                Section {
                    Button(action: {
                        showLogoutAlert.toggle()
                    }) {
                        Text("Logout")
                            .foregroundColor(.red)
                    }
                    .alert(isPresented: $showLogoutAlert) {
                        Alert(
                            title: Text("Logout"),
                            message: Text("Are you sure you want to log out?"),
                            primaryButton: .destructive(Text("Logout")) {
                                print("User logged out")
                                isLoggedIn = false
                            },
                            secondaryButton: .cancel()
                        )
                    }
                }
            }
            }
            .navigationBarTitle("Settings")
        }
    }
