//
//  PodcastDetailView.swift
//  Tolki
//
//  Created by Эльвира on 24.12.2024.
//


import SwiftUI

// Страница с детальной информацией о подкасте
struct PodcastDetailView: View {
    let podcast: Podcast

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Заголовок
                Text(podcast.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 20)

                // Описание
                Text(podcast.description)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .padding(.bottom, 20)

                // Средняя оценка
                Text(podcast.averageRating)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                // Дата создания
                Text("Дата создания: \(podcast.createdAt)")
                    .font(.subheadline)
                    .foregroundColor(.gray)

                // Ссылка на подкаст
                Link("Перейти к подкасту", destination: URL(string: podcast.url)!)
                    .font(.subheadline)
                    .foregroundColor(.blue)
                    .padding(.top, 20)
            }
            .padding()
        }
        .navigationTitle("Подкаст: \(podcast.name)")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct PodcastDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PodcastDetailView(podcast: Podcast(id: 1, name: "Example Podcast", description: "This is a description of the podcast.", cover: "cover_test.png", createdAt: "2024-12-24", averageRating: "Average Rating: 42/100", url: "http://localhost:3000/api/v1/podcasts/1"))
    }
}
