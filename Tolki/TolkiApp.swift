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
    @StateObject var themeManager = ThemeManager()  // Инициализируем менеджер тем

    var body: some Scene {
        WindowGroup {
            if isLoggedIn {
                MainTabView(isLoggedIn: $isLoggedIn)  // Передаем isLoggedIn как Binding
                    .environmentObject(themeManager)
            } else {
                ContentView()
                    .environmentObject(themeManager)
            
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(ThemeManager())
    
}

