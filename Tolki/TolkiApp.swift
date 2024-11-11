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
    
    var body: some Scene {
        WindowGroup {
            if isLoggedIn {
                MainView()  // Показываем основной экран, если пользователь авторизован
            } else {
                ContentView()  // Показываем экран контента (онбординг или вход)
            }
        }
    }
}

