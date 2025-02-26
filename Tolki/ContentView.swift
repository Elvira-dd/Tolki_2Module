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
    @State private var showPassword: Bool = false

    var body: some View {
        VStack {
            if viewModel.gotToken {
                MainTabView()
            } else {
                ZStack {
                    Color(.background)
                        .edgesIgnoringSafeArea(.all)
                    VStack {
                        Text("Вход")
                            .headingTextStyle()
                            .foregroundColor(Color(.mainGreen))
                        
                        TextField("Введите email", text: $email)
                            .textContentType(.emailAddress)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 10)
                            .foregroundColor(Color(.mainLight))
                            .background(Color(.mainLight2))
                            .cornerRadius(8)
                            .padding()
                        
                        HStack {
                            if showPassword {
                                TextField("Введите пароль", text: $password)
                            } else {
                                SecureField("Введите пароль", text: $password)
                            }

                            Button(action: {
                                showPassword.toggle()
                            }) {
                                Image(systemName: showPassword ? "eye.slash.fill" : "eye.fill")
                                    .foregroundColor(Color(.mainLight))
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .background(Color(.mainLight2))
                        .cornerRadius(8)
                        .padding()
                        
                        Button("Войти") {
                            viewModel.signIn(email: email, password: password)
                        }
                        .buttonTextStyle()
                        .padding(.horizontal, 48)
                        .padding(.vertical, 10)
                        .foregroundColor(Color(.mainLight5))
                        .background(Color(.mainGreen))
                        .cornerRadius(8)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding()

                        NavigationLink(destination: RegView(viewModel: viewModel)) {
                            Text("Еще нет аккаунта? Зарегистрируйтесь")
                                .foregroundColor(Color(.mainGreen))
                                .underline()
                        }
                        .padding(.top, 20)
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct RegView: View {
    @ObservedObject var viewModel: ViewModel
    @State var password_confirmation: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State private var showPassword: Bool = false

    var body: some View {
        VStack {
            if viewModel.gotToken {
                MainTabView()
            } else {
                ZStack {
                    Color(.background)
                        .edgesIgnoringSafeArea(.all)
                    VStack {
                        Text("Регистрация")
                            .headingTextStyle()
                            .foregroundColor(Color(.mainGreen))
                        
                        TextField("Введите email", text: $email)
                            .textContentType(.emailAddress)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 10)
                            .foregroundColor(Color(.mainLight))
                            .background(Color(.mainLight2))
                            .cornerRadius(8)
                            .padding()
                        
                        HStack {
                            if showPassword {
                                TextField("Введите пароль", text: $password)
                            } else {
                                SecureField("Введите пароль", text: $password)
                            }
                            
                            Button(action: {
                                showPassword.toggle()
                            }) {
                                Image(systemName: showPassword ? "eye.slash.fill" : "eye.fill")
                                    .foregroundColor(Color(.mainLight))
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .background(Color(.mainLight2))
                        .cornerRadius(8)
                        .padding()
                        
                        HStack {
                            if showPassword {
                                TextField("Подтвердите пароль", text: $password_confirmation)
                            } else {
                                SecureField("Подтвердите пароль", text: $password_confirmation)
                            }
                            
                            Button(action: {
                                showPassword.toggle()
                            }) {
                                Image(systemName: showPassword ? "eye.slash.fill" : "eye.fill")
                                    .foregroundColor(Color(.mainLight))
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .background(Color(.mainLight2))
                        .cornerRadius(8)
                        .padding()
                        
                        Button("Зарегистрироваться") {
                            viewModel.signUp(email: email, password: password, passwordConfirmation: password_confirmation)
                        }
                        .buttonTextStyle()
                        .padding(.horizontal, 48)
                        .padding(.vertical, 10)
                        .foregroundColor(Color(.mainLight5))
                        .background(Color(.mainGreen))
                        .cornerRadius(8)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding()
                        
                        NavigationLink(destination: ContentView(viewModel: viewModel)) {
                            Text("Есть аккаунт? Войдите")
                                .foregroundColor(Color(.mainGreen))
                                .underline()
                        }
                        .padding(.top, 20)
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}




#Preview {
    ContentView(viewModel: ViewModel())
}



