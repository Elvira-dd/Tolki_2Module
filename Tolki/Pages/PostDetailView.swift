//
//  PostDetailView.swift
//  Tolki
//
//  Created by Эльвира on 24.12.2024.
//


import SwiftUI
struct PostDetailView: View {
    let post: Posts

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(post.title)
                    .font(.title)
                    .bold()

                if let content = post.content {
                    Text(content)
                        .font(.body)
                } else {
                    Text("Контент отсутствует.")
                        .font(.body)
                        .foregroundColor(.gray)
                }

                if let comments = post.comments {
                    Text("Комментарии (\(comments.count)):")
                        .font(.headline)
                        .padding(.top)

                    ForEach(comments) { comment in
                        Text(comment.content)
                            .font(.body)
                            .padding(10)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                } else {
                    Text("Комментарии недоступны.")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }

                // Отображение issueId
                let issueId = post.issueId
                    Text("Идентификатор выпуска: \(issueId)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.top, 10)
                

                Spacer()
            }
            .padding()
        }
        .navigationTitle("Детали поста")
    }
}
