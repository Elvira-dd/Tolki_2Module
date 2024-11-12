//
//  ProfileView.swift
//  Tolki
//
//  Created by Эльвира on 12.11.2024.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @State private var user: UserProfile = UserProfile(firstName: "John", lastName: "Doe", email: "john.doe@example.com", avatar: UIImage(named: "avatar_placeholder"))
    @State private var isEditing: Bool = false
    @State private var selectedImage: UIImage?
    
    var body: some View {
        NavigationView {
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
                    .font(.largeTitle)
                    .foregroundColor(themeManager.currentTheme.textColor)
                    .padding(.top, 20)
                
                Text(user.email)
                    .font(.subheadline)
                    .foregroundColor(themeManager.currentTheme.textColor)
                    .padding(.top, 5)
                
                Spacer()
                
                Button("Edit Profile") {
                    isEditing.toggle()
                }
                .padding()
                .foregroundColor(themeManager.currentTheme.buttonTextColor)
                .background(themeManager.currentTheme.buttonColor)
                .cornerRadius(8)
            }
            .padding()
            .background(themeManager.currentTheme.backgroundColor)
            .navigationBarTitle("Profile", displayMode: .inline)
        }
    }
}

struct UserProfile: Identifiable {
    var id = UUID()
    var firstName: String
    var lastName: String
    var email: String
    var avatar: UIImage?
}
