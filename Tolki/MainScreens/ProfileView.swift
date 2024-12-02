//
//  ProfileView.swift
//  Tolki
//
//  Created by Эльвира on 12.11.2024.
//

import SwiftUI

struct ProfileView: View {
    @Binding var isLoggedIn: Bool  // Ссылка на состояние авторизации
    @EnvironmentObject var themeManager: ThemeManager
    @State private var user: UserProfile = UserProfile(
        firstName: "John",
        lastName: "Doe",
        email: "john.doe@example.com",
        avatar: UIImage(named: "avatar_placeholder")
    )
    @State private var isEditing: Bool = false
    @State private var selectedImage: UIImage?  // Добавляем состояние для выбранного изображения
    @State private var navigateToContentView: Bool = false  // Флаг для перехода на ContentView

    var body: some View {
                VStack {
                    if let avatar = user.avatar {
                        Image(uiImage: avatar)
                            .resizable()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 4))
                            .shadow(radius: 10)
                    } else {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 4))
                            .shadow(radius: 10)
                    }

                    Text("\(user.firstName) \(user.lastName)")
                        .headingTextStyle()
                        .padding(.top, 20)

                    Text(user.email)
                        .padding(.top, 5)

                    Spacer()

                    Button(action: {
                        isEditing.toggle()
                    }) {
                        Text("Edit Profile")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 200, height: 50)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .sheet(isPresented: $isEditing) {
                        EditProfileView(user: $user, selectedImage: $selectedImage) // Передаем selectedImage в EditProfileView
                    }


                    Button(action: {
                        isLoggedIn = false  // Устанавливаем авторизацию в false, чтобы выйти из профиля
                        navigateToContentView = true  // Активируем переход на ContentView
                    }) {
                        Text("Log Out")
                            .font(.headline)
                            .foregroundColor(themeManager.currentTheme.textColor)
                            .padding()
                            .frame(width: 200, height: 50)
                            .background(themeManager.currentTheme.secondaryBackgroundColor)
                            .cornerRadius(10)
                    }
                    .padding(.top, 20)

                    // NavigationLink с флагом для активации перехода
                    NavigationLink(destination: ContentView(), isActive: $navigateToContentView) {
                        EmptyView()  // Скрытый элемент, который активирует редирект
                        
                    }
                }
                .padding()
                .containerRelativeFrame([.horizontal, .vertical])
                .background(themeManager.currentTheme.backgroundColor)
                
                
            }
    
        }



struct UserProfile: Identifiable {
    var id = UUID()
    var firstName: String
    var lastName: String
    var email: String
    var avatar: UIImage?
}

#Preview {
    var isLoggedIn = true
    ProfileView(isLoggedIn: .constant(isLoggedIn))
        .environmentObject(ThemeManager())
}
