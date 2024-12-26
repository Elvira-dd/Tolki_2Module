import SwiftUI

// Страница с детальной информацией о подкасте
struct PodcastDetailView: View {
    let podcast: Podcast
    @StateObject var podcastFetcher = PodcastFetcher()

    var filteredIssues: [Issue] {
        // Фильтруем выпуски по podcastId
        podcastFetcher.issues.filter { $0.podcastId == podcast.id }
    }

    var body: some View {
        ZStack {
            // Фон MainLight из ассетов
            Color("MainLight")
                .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Обложка подкаста
                    if let coverURL = URL(string: podcast.cover) {
                        AsyncImage(url: coverURL) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(height: 200)
                                .cornerRadius(12)
                        } placeholder: {
                            Rectangle()
                                .fill(Color.gray.opacity(0.3))
                                .frame(height: 200)
                                .cornerRadius(12)
                        }
                    }

                    // Название подкаста
                    Text(podcast.name)
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.primary)
                        .padding(.top, 10)

                    // Описание подкаста
                    Text(podcast.description)
                        .font(.body)
                        .foregroundColor(.secondary)
                        .lineLimit(3)
                        .padding(.vertical, 10)

                    // Средняя оценка и дата создания
                    HStack {
                        Text(podcast.averageRating)
                            .font(.headline)
                            .foregroundColor(Color("MainGreen"))
                        Spacer()
                        Text("Дата создания: \(podcast.createdAt)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }

                    // Ссылка на подкаст
                    Link(destination: URL(string: podcast.url)!) {
                        Text("Перейти к подкасту")
                            .font(.headline)
                            .foregroundColor(Color("MainGreen"))
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color("MainGreen").opacity(0.1))
                            .cornerRadius(8)
                    }
                    .padding(.vertical, 10)

                    // Заголовок для выпусков
                    Text("Выпуски:")
                        .font(.title2)
                        .bold()
                        .padding(.top, 20)

                    // Список выпусков
                    ForEach(filteredIssues) { issue in
                        NavigationLink(destination: IssueDetailView(issue: issue)) {
                            HStack(alignment: .top, spacing: 12) {
                                VStack {
                                    Rectangle()
                                        .fill(Color.gray.opacity(0.1))
                                        .frame(width: 80, height: 80)
                                        .cornerRadius(8)
                                }

                                VStack(alignment: .leading, spacing: 8) {
                                    Text(issue.name)
                                        .font(.headline)
                                        .foregroundColor(.primary)

                                    Text("Идентификатор выпуска: \(issue.id)")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                        .lineLimit(1)

                                    Link("Перейти к выпуску", destination: URL(string: issue.url)!)
                                        .font(.subheadline)
                                        .foregroundColor(Color("MainGreen"))
                                }
                            }
                            .padding()
                            .background(Color.gray.opacity(0.05))
                            .cornerRadius(10)
                            .shadow(radius: 2, x: 0, y: 2)
                        }
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Подкаст: \(podcast.name)")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            podcastFetcher.fetchData()
        }
    }
}

struct PodcastDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PodcastDetailView(podcast: Podcast(id: 1, name: "Example Podcast", description: "This is a description of the podcast.", cover: "https://via.placeholder.com/300", createdAt: "2024-12-24", averageRating: "42/100", url: "http://localhost:3000/api/v1/podcasts/1"))
    }
}
