//
//  PodcastPage.swift
//  Tolki
//
//  Created by Эльвира on 24.12.2024.
//

import SwiftUI

// 3. Вид для отображения подкастов
struct PodcastCard: View {
    let podcast: Podcast

    var body: some View {
            VStack(alignment: .leading, spacing: 10) {
                Text(podcast.name)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .lineLimit(2)

                Text(podcast.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(3)

                Text(podcast.averageRating)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding()
            .background(Color.black.opacity(0.05))
            .cornerRadius(12)
            .frame(width: 300)
        }
    
}

// 4. Шаблон для секции
struct PSectionView<Item: Hashable, Content: View>: View {
    let title: String
    let items: [Item]
    let content: (Item) -> Content
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .padding(.bottom, 5)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(items, id: \.self) { item in
                        content(item)
                    }
                }
            }
        }
    }
}

// 5. Страница для подкастов
struct PodcastSectionView: View {
    let podcasts: [Podcast]

    var body: some View {
            ScrollView {
                PSectionView(title: "Подкасты", items: podcasts) { podcast in
                    NavigationLink(destination: PodcastDetailView(podcast: podcast)) {
                        PodcastCard(podcast: podcast)
                    }
                }
                .padding()
        }
    }
}

// 6. Основной экран с подкастами
struct PodcastView: View {
    @StateObject private var fetcher = PodcastFetcher()
        @State private var currentPage: Int = 1

        var body: some View {
            NavigationStack {
                TabView(selection: $currentPage) {
                    PodcastSectionView(podcasts: fetcher.podcasts)
                        .tag(1)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                .onAppear {
                    fetcher.fetchData()
                }
            }
        }
}

struct PodcastView_Previews: PreviewProvider {
    static var previews: some View {
        PodcastView()
    }
}
