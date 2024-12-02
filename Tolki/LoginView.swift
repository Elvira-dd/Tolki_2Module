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
                    .headingTextStyle()
                    .foregroundColor(themeManager.currentTheme.textColor)

                TextField("Введите email", text: $email)
                    .padding(.horizontal, 16) // Горизонтальные отступы (внутренние)
                    .padding(.vertical, 10)
                    
                    .background(themeManager.currentTheme.secondaryBackgroundColor)
                    .cornerRadius(8)
                    .padding()
                
                SecureField("Введите пароль", text: $password)
                    .padding(.horizontal, 16) // Горизонтальные отступы (внутренние)
                    .padding(.vertical, 10)
                    .background(themeManager.currentTheme.secondaryBackgroundColor)
                    .cornerRadius(8)
                    .padding()
                
                Button("Войти") {
                    // Логика авторизации
                    if email == "1231111.ком" && password == "1234" {
                        isLoggedIn = true  // Устанавливаем авторизацию
                        print("Вход успешен")
                    } else {
                        // Показываем ошибку авторизации
                        print("Неверные данные")
                    }
                }
                .buttonTextStyle()
                .padding(.horizontal, 48) // Горизонтальные отступы (внутренние)
                .padding(.vertical, 10)
                .foregroundColor(themeManager.currentTheme.buttonTextColor)
                .background(themeManager.currentTheme.buttonColor)
                .cornerRadius(8)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding()
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
