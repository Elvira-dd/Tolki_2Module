//
//  MainTabView.swift
//  Tolki
//
//  Created by Эльвира on 12.11.2024.
//

import SwiftUI

struct MainTabView: View {
    @Binding var isLoggedIn: Bool  // Ссылка на состояние авторизации
    @EnvironmentObject var themeManager: ThemeManager  // Подключение ThemeManager как EnvironmentObject

    var body: some View {
        TabView {
            MainView()
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
        .background(themeManager.currentTheme.backgroundColor)
    }
}

#Preview {
    var isLoggedIn = true
    MainTabView(isLoggedIn: .constant(isLoggedIn))  // Создаю привязку на основе глобальной переменной
        .environmentObject(ThemeManager())  // Подключаю ThemeManager
}


