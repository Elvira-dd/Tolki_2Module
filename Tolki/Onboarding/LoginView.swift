//
//  LoginView.swift
//  Tolki
//
//  Created by Эльвира on 11.11.2024.
//

import SwiftUI
 
struct LoginView: View {
  
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        ZStack {
            // Задаем фон для всего экрана
            Color(.systemBackground)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Вход")
                    .headingTextStyle()
                    .foregroundColor(Color.primary)

                TextField("Введите email", text: $email)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    .background(Color.secondary)
                    .cornerRadius(8)
                    .padding()
                
                SecureField("Введите пароль", text: $password)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    .background(Color.secondary)
                    .cornerRadius(8)
                    .padding()
                
                Button("Войти") {
                   
                }
                .buttonTextStyle()
                .padding(.horizontal, 48)
                .padding(.vertical, 10)
                .foregroundColor(Color.white)
                .background(Color.blue)
                .cornerRadius(8)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding()
            }
            .padding()
        }
    }
}

#Preview {

    LoginView()
}
