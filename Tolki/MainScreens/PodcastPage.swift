import SwiftUI

// Карточка подкаста с улучшенным дизайном
struct PodcastCard: View {
    let podcast: Podcast

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // Заголовок подкаста
            Text(podcast.name)
                .font(.headline)
                .foregroundColor(.primary)
                .lineLimit(2)

            // Описание подкаста
            Text(podcast.description)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineLimit(3)

            // Средняя оценка
            Text(podcast.averageRating)
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color("MainLight")) // Фон из ассетов
        .cornerRadius(16)               // Увеличенный радиус
        .shadow(color: .gray.opacity(0.2), radius: 8, x: 0, y: 4) // Тень для объема
        .frame(width: 300)              // Фиксированная ширина
    }
}

// Шаблон секции с улучшенным оформлением
struct PSectionView<Item: Hashable, Content: View>: View {
    let title: String
    let items: [Item]
    let content: (Item) -> Content

    var body: some View {
        VStack(alignment: .leading) {
            // Заголовок секции
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
                .padding(.horizontal)
                .padding(.top, 10)

            // Горизонтальный скролл с подкастами
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(items, id: \.self) { item in
                        content(item)
                    }
                }
                .padding(.horizontal)
            }
        }
        .padding(.bottom, 10) // Отступ между секциями
    }
}

// Секция подкастов
struct PodcastSectionView: View {
    let podcasts: [Podcast]

    var body: some View {
        ScrollView {
            PSectionView(title: "Популярные подкасты", items: podcasts) { podcast in
                NavigationLink(destination: PodcastDetailView(podcast: podcast)) {
                    PodcastCard(podcast: podcast)
                }
            }
            .padding(.vertical)
        }
        .background(Color("MainLight")) // Фон страницы из ассетов
    }
}

// Основной экран подкастов
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
            .background(Color("MainLight")) // Фон из ассетов
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
