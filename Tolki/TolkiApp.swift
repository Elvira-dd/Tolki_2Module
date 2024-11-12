//
//  TolkiApp.swift
//  Tolki
//
//  Created by Эльвира on 11.11.2024.
//

import SwiftUI

@main
struct MyApp: App {
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false  // Состояние авторизации
    @StateObject var themeManager = ThemeManager()
    
    var body: some Scene {
        WindowGroup {
            if isLoggedIn {
                MainTabView()  // Показываем основной экран, если пользователь авторизован
                .environmentObject(themeManager)
            } else {
                ContentView()  // Показываем экран контента (онбординг или вход)
                .environmentObject(themeManager)
            }
        }
    }
}

#Preview {
    MainTabView()
}
