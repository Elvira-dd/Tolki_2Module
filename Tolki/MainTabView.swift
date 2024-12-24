//
//  MainTabView.swift
//  Tolki
//
//  Created by Эльвира on 12.11.2024.
//

import SwiftUI


struct MainTabView: View {
    @Binding var isLoggedIn: Bool
    @EnvironmentObject var themeManager: ThemeManager

    var body: some View {
        TabView {
            PostsView()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Cards")
                }

            ProfileView(isLoggedIn: $isLoggedIn)
                .tabItem {
                    Image(systemName: "person.circle")
                    Text("Profile")
                }

            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
        }
        .background(themeManager.currentTheme.backgroundColor)  // Фон для всего TabView
        .ignoresSafeArea()  // Игнорируем безопасную зону, чтобы фон был полностью на экране
    }
}


#Preview {
    var isLoggedIn = true
    MainTabView(isLoggedIn: .constant(isLoggedIn))  // Создаю привязку на основе глобальной переменной
        .environmentObject(ThemeManager())  // Подключаю ThemeManager
}


