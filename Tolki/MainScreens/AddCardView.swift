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
    @State private var text: String = ""
    @State private var issue_name: String = ""
    @State private var podcast_name: String = ""
    @State private var hashtag: String = ""
    @State private var user_name: String = "Ксения"
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Post Details")) {
                    TextField("Title", text: $title)
                        .autocapitalization(.words)
                        .disableAutocorrection(true)
                    
                    ZStack(alignment: .topLeading) {
                        if text.isEmpty {
                            Text("Text")
                                .foregroundColor(.gray)
                                .padding(.top, 8)
                                .padding(.leading, 5)
                        }
                        TextEditor(text: $text)
                            .autocapitalization(.sentences)
                            .frame(height: 100)
                            .padding(4)
                    }
                    
                    TextField("Issue Name", text: $issue_name)
                        .autocapitalization(.none)
                    
                    TextField("Podcast Name", text: $podcast_name)
                        .autocapitalization(.none)
                    
                    TextField("Hashtag", text: $hashtag)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                }
                
                Section {
                    Button(action: addPost) {
                        Text("Add Post")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(title.isEmpty || text.isEmpty)
                }
            }
            .navigationBarTitle("Add Post", displayMode: .inline)
            .navigationBarItems(trailing: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
    
    private func addPost() {
        let predefinedTags = ["Мое", "Новое"]
        let newPost = Post(
            id: posts.count + 1,
            title: title,
            text: text,
            user_name: user_name,
            issue_name: issue_name,
            podcast_name: podcast_name,
            hashtag: hashtag,
            tags: predefinedTags
        )
        
        posts.append(newPost)
        presentationMode.wrappedValue.dismiss()
    }
}


