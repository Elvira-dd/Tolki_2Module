//
//  IssueDetailView.swift
//  Tolki
//
//  Created by Эльвира on 24.12.2024.
//
import SwiftUI
struct IssueDetailView: View {
    let issue: Issue
    @StateObject var dataFetcher = DataFetcher() // Создаем экземпляр DataFetcher
    @State private var postsForIssue: [Posts] = []

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Название выпуска
                Text(issue.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 20)

                // Описание выпуска
                Text("Описание выпуска:")
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                Text(issue.link)
                    .font(.body)
                    .foregroundColor(.primary)
                    .padding(.bottom, 20)

                // Дата выпуска
                Text("Дата создания: \(issue.createdAt)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                // Изображение обложки
                AsyncImage(url: URL(string: issue.cover)) { image in
                    image.resizable()
                         .scaledToFit()
                         .frame(width: 200, height: 200)
                } placeholder: {
                    ProgressView()
                }
                
                // Ссылка на выпуск
                Link("Перейти к выпуску", destination: URL(string: issue.url)!)
                    .font(.subheadline)
                    .foregroundColor(.blue)
                    .padding(.top, 20)

                // Посты, относящиеся к текущему выпуску
                VStack(alignment: .leading, spacing: 15) {
                    Text("Посты этого выпуска:")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    
                    ForEach(postsForIssue, id: \.id) { post in
                        Text(post.title)
                            .font(.body)
                            .foregroundColor(.primary)
                            .padding(.vertical, 5)
                    }
                }
                .padding(.top, 20)
            }
            .padding()
        }
        .onAppear {
            dataFetcher.fetchData() // Загружаем посты при появлении экрана
            filterPosts() // Фильтруем посты по issueId
        }
        .navigationTitle("Выпуск: \(issue.name)")
        .navigationBarTitleDisplayMode(.inline)
    }

    // Функция для фильтрации постов по issueId
    private func filterPosts() {
        postsForIssue = dataFetcher.posts.filter { post in
            post.issueId == issue.id
            
        }
    }
}
