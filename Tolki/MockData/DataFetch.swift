//
//  DataFetch.swift
//  Tolki
//
//  Created by Эльвира on 24.12.2024.
//

import SwiftUI
// Загружаю данные
import Foundation

class DataFetcher: ObservableObject {
    @Published var posts: [Posts] = []

    func fetchData() {
        guard let url = URL(string: "http://localhost:3000/api/v1/posts") else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let fetchedPosts = try decoder.decode([Posts].self, from: data)
                    DispatchQueue.main.async {
                        self.posts = fetchedPosts
                    }
                } catch {
                    print("Ошибка декодирования: \(error)")
                }
            }
        }.resume()
    }
}

class PodcastFetcher: ObservableObject {
    @Published var podcasts: [Podcast] = []
    @Published var issues: [Issue] = []

    func fetchData() {
        // Получаем подкасты
        guard let podcastsURL = URL(string: "http://localhost:3000/api/v1/podcasts") else { return }
        URLSession.shared.dataTask(with: podcastsURL) { data, _, error in
            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode([Podcast].self, from: data)
                    DispatchQueue.main.async {
                        self.podcasts = decodedData
                    }
                } catch {
                    print("Error decoding podcasts JSON:", error)
                }
            } else if let error = error {
                print("Network error (podcasts):", error)
            }
        }.resume()
        
        // Получаем все выпуски
        guard let issuesURL = URL(string: "http://localhost:3000/api/v1/issues") else { return }
        URLSession.shared.dataTask(with: issuesURL) { data, _, error in
            if let data = data {
                do {
                    let decodedIssues = try JSONDecoder().decode([Issue].self, from: data)
                    DispatchQueue.main.async {
                        self.issues = decodedIssues
                    }
                } catch {
                    print("Error decoding issues JSON:", error)
                }
            } else if let error = error {
                print("Network error (issues):", error)
            }
        }.resume()
    }
}
