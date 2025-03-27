//
//  ProfileView.swift
//  Tolki
//
//  Created by Эльвира on 12.11.2024.
//

import SwiftUI

struct ProfileView: View {
    @State private var user: UserProfile = UserProfile(
        firstName: "Ксения",
        lastName: "Кириленко",
        email: "kirilenko@yandex.ru",
        avatar: UIImage(named: "avatar_placeholder")
    )
    @State private var isEditing: Bool = false
    @State private var selectedImage: UIImage?
    @State private var navigateToContentView: Bool = false

    var body: some View {
        ScrollView {
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
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .padding(.top, 10)

                Text(user.email)
                    .padding(.top, 5)

                Spacer()

                Button(action: {
                    isEditing.toggle()
                }) {
                    Text("Edit Profile")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                }
                .sheet(isPresented: $isEditing) {
                    EditProfileView(user: $user, selectedImage: $selectedImage)
                }

                Button(action: {
                    navigateToContentView = true
                }) {
                    Text("Log Out")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color.red)
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                }
                .padding(.top, 10)

                NavigationLink(destination: ConView(), isActive: $navigateToContentView) {
                    EmptyView()
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 20) // Добавляем отступы, чтобы контент не прижимался
        }
        .background(Color(.systemBackground))
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
