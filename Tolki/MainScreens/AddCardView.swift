//
//  AddCardView.swift
//  Tolki
//
//  Created by Эльвира on 12.11.2024.
//

import SwiftUI

struct AddPostView: View {
    @Binding var posts: [Post]
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var tags: String = ""
    
    // Для закрытия модального окна
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Card Information")) {
                    TextField("Title", text: $title)
                        .autocapitalization(.words)
                        .disableAutocorrection(true)
                    
                    TextField("Description", text: $description)
                        .autocapitalization(.sentences)
                    
                    TextField("Tags (comma separated)", text: $tags)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                }
                
                Section {
                    Button(action: addPost) {
                        Text("Add Card")
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
            .navigationBarTitle("Add Card", displayMode: .inline)
            .navigationBarItems(trailing: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
    
    private func addPost() {
        let tagList = tags.split(separator: ",").map {
            $0.trimmingCharacters(in: .whitespaces)
        }
        let newPost = Post(id: posts.count + 1, title: title, description: description, tags: tagList)
        posts.append(newPost)
        
        // Закрыть модальное окно после добавления карточки
        presentationMode.wrappedValue.dismiss()
    }
}
