//
//  PostDetailView.swift
//  Tolki
//
//  Created by Эльвира on 27.03.2025.
//

import SwiftUI

struct PostDetailView: View {
    var post: Post
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(post.title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("Дата создания: \(post.createdAt)")
                    .font(.subheadline)
                
                Text(post.content)
                    .font(.body)
                    .lineLimit(nil) // Показать весь контент поста
            }
            .padding()
            // Раздел для комментариев
            VStack(alignment: .leading) {
                Text("Комментарии:")
                    .font(.headline)
                ForEach(post.comments) { comment in
                    VStack(alignment: .leading, spacing: 8) {
                        Text("User \(comment.userId):")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        
                        Text(comment.content)
                            .font(.body)
                            .padding(.bottom, 10)
                    }
                }
            }
            .padding(.top)
        }
        .navigationTitle("Пост")
        
    }
}
