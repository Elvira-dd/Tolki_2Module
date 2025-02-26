//
//  ProfileView.swift
//  Tolki
//
//  Created by Эльвира on 12.11.2024.
//

import SwiftUI

struct ProfileView: View {
   // Ссылка на состояние авторизации
    @State private var user: UserProfile = UserProfile(
        firstName: "Ксения",
        lastName: "Кириленко",
        email: "kirilenko@yandex.ru",
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
                .font(.title) // Заменяем headingTextStyle на стандартный заголовок
                .multilineTextAlignment(.center)
                .padding(.top, 20)

            Text(user.email)
                .padding(.top, 5)

            Spacer()

            Button(action: {
                isEditing.toggle()
            }) {
                Text("Edit Profile")
                    .font(.headline)
                    .foregroundColor(.white) // Заменяем цвет на стандартный
                    .padding()
                    .frame(width: 200, height: 50)
                    .background(Color.blue) // Заменяем цвет кнопки на стандартный
                    .cornerRadius(10)
            }
            .sheet(isPresented: $isEditing) {
                EditProfileView(user: $user, selectedImage: $selectedImage) // Передаем selectedImage в EditProfileView
            }

            Button(action: {
               
                navigateToContentView = true  // Активируем переход на ContentView
            }) {
                Text("Log Out")
                    .font(.headline)
                    .foregroundColor(.white) // Заменяем цвет на стандартный
                    .padding()
                    .frame(width: 200, height: 50)
                    .background(Color.red) // Заменяем цвет кнопки на стандартный
                    .cornerRadius(10)
            }
            .padding(.top, 20)

            // NavigationLink с флагом для активации перехода
            NavigationLink(destination: ConView(), isActive: $navigateToContentView) {
                EmptyView()  // Скрытый элемент, который активирует редирект
            }
        }
        .padding()
        .background(Color(.systemBackground)) // Используем стандартный цвет фона
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

    ProfileView()
}
