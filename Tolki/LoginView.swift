//
//  LoginView.swift
//  Tolki
//
//  Created by Эльвира on 11.11.2024.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @Binding var isLoggedIn: Bool
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        VStack {
            TextField("Введите email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .foregroundColor(themeManager.currentTheme.textColor)
            SecureField("Введите пароль", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .foregroundColor(themeManager.currentTheme.textColor)
            
            Button("Войти") {
                if email == "1234@example.com" && password == "123456" {
                    isLoggedIn = true
                } else {
                    print("Неверные данные")
                }
            }
            .padding()
            .foregroundColor(themeManager.currentTheme.buttonTextColor)
            .background(themeManager.currentTheme.buttonColor)
            .cornerRadius(8)
        }
        .padding()
        .background(themeManager.currentTheme.backgroundColor)
    }
}
