//
//  EditProfileView.swift
//  Tolki
//
//  Created by Эльвира on 12.11.2024.
//

//import SwiftUI
//
//struct EditProfileView: View {
//    @Binding var user: UserProfile
//    @Binding var selectedImage: UIImage?
//    @State private var firstName: String = ""
//    @State private var lastName: String = ""
//    @State private var email: String = ""
//    @State private var showImagePicker: Bool = false
//    @Environment(\.presentationMode) var presentationMode
//    
//    var body: some View {
//        NavigationView {
//            Form {
//                // Секция для аватарки
//                Section(header: Text("Avatar")) {
//                    Button(action: {
//                        showImagePicker.toggle()
//                    }) {
//                        if let selectedImage = selectedImage {
//                            Image(uiImage: selectedImage)
//                                .resizable()
//                                .frame(width: 100, height: 100)
//                                .clipShape(Circle())
//                        } else {
//                            Image(systemName: "person.circle.fill")
//                                .resizable()
//                                .frame(width: 100, height: 100)
//                                .clipShape(Circle())
//                        }
//                    }
//                }
//
//                // Секция с личной информацией
//                Section(header: Text("Personal Information")) {
//                    TextField("First Name", text: $firstName)
//                    TextField("Last Name", text: $lastName)
//                    TextField("Email", text: $email)
//                        .keyboardType(.emailAddress)
//                }
//            }
//            .navigationBarTitle("Edit Profile")
//            .navigationBarItems(
//                leading: Button("Cancel") {
//                    presentationMode.wrappedValue.dismiss()
//                },
//                trailing: Button("Save") {
//                    user.firstName = firstName
//                    user.lastName = lastName
//                    user.email = email
//                    if let selectedImage = selectedImage {
//                        user.avatar = selectedImage
//                    }
//                    presentationMode.wrappedValue.dismiss()
//                }
//            )
//            .onAppear {
//                firstName = user.firstName
//                lastName = user.lastName
//                email = user.email
//            }
//            .sheet(isPresented: $showImagePicker) {
//                ImagePicker(image: $selectedImage)
//            }
//        }
//        .background(Color.background)
//    }
//}
