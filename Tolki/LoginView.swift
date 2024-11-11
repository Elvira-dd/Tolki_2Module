//
//  LoginView.swift
//  Tolki
//
//  Created by Эльвира on 11.11.2024.
//

import SwiftUI

import SwiftUI

struct LoginView: View {
    @Binding var isLoggedIn: Bool  // Ссылка на состояние авторизации
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        VStack {
            TextField("Введите email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            SecureField("Введите пароль", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Войти") {
                // Логика авторизации
                if email == "user@example.com" && password == "password123" {
                    isLoggedIn = true  // Устанавливаем авторизацию
                } else {
                    // Показываем ошибку авторизации
                    print("Неверные данные")
                }
            }
            .padding()
        }
        .padding()
    }
}
