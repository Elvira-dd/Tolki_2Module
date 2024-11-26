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
        ZStack {
            // Задаем фон для всего экрана
            themeManager.currentTheme.backgroundColor
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Вход")
                    .font(.largeTitle)
                    .foregroundColor(themeManager.currentTheme.textColor)  // Цвет текста

                TextField("Введите email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                SecureField("Введите пароль", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button("Войти") {
                    // Логика авторизации
                    if email == "123@111.com" && password == "1234" {
                        isLoggedIn = true  // Устанавливаем авторизацию
                    } else {
                        // Показываем ошибку авторизации
                        print("Неверные данные")
                    }
                }
                .padding()
                .foregroundColor(themeManager.currentTheme.buttonTextColor)
                .background(themeManager.currentTheme.buttonColor)
                .cornerRadius(10)
            }
            .padding()
        }
    }
}

#Preview {
    var isLoggedIn = true
    LoginView(isLoggedIn: .constant(isLoggedIn))
        .environmentObject(ThemeManager())  // Подключаем ThemeManager
}
