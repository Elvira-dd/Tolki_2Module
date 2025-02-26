//
//  ContentView.swift
//  Tolki
//
//  Created by Эльвира on 26.02.2025.
//



import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ViewModel
    @State var password_confirmation: String = ""
    @State var email: String = ""
    @State var password: String = ""

    var body: some View {
        VStack {
            if viewModel.gotToken {
                MainTabView()
                
            } else {
                ZStack {

                    Color(.white)
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
                            viewModel.signIn(email: email, password: password )
                            
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
        .padding()
        
    }
}




#Preview {
    ContentView(viewModel: ViewModel())
}
