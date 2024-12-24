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
            MainView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Главная")
                }
            
            PodcastView()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Подкасты")
                }
            CreatePostView()
                .tabItem {
                    Image(systemName: "plus")
                    Text("Новый пост")
                }
            
            ProfileView(isLoggedIn: $isLoggedIn)
                .tabItem {
                    Image(systemName: "person.circle")
                    Text("Профиль")
                }

            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Настройки")
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


