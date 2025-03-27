//
//  DataFetch.swift
//  Tolki
//
//  Created by Эльвира on 24.12.2024.
//

import SwiftUI
import Foundation






class PodcastService {
    static let shared = PodcastService()
    
    // URL для фетчинга данных о подкастах
    private let podcastsURL = URL(string: "http://localhost:3000/api/v1/podcasts")!
    
    func fetchPodcasts(completion: @escaping ([Podcast]?) -> Void) {
        let task = URLSession.shared.dataTask(with: podcastsURL) { data, response, error in
            if let data = data {
                do {
                    let podcasts = try JSONDecoder().decode([Podcast].self, from: data)
                    completion(podcasts)
                } catch {
                    print("Ошибка при декодировании данных: \(error)")
                    if let decodingError = error as? DecodingError {
                        switch decodingError {
                        case .keyNotFound(let key, let context):
                            print("Не найден ключ: \(key) в пути: \(context.codingPath)")
                        case .typeMismatch(let type, let context):
                            print("Ошибка типа: \(type) в пути: \(context.codingPath)")
                        case .valueNotFound(let value, let context):
                            print("Не найдено значение: \(value) в пути: \(context.codingPath)")
                        case .dataCorrupted(let context):
                            print("Коррупция данных: \(context)")
                        @unknown default:
                            print("Неизвестная ошибка декодирования")
                        }
                    }
                    completion(nil)
                }
            } else {
                print("Ошибка при загрузке данных: \(String(describing: error))")
                completion(nil)
            }
        }
        task.resume()
    }
}


class ThemeFetcher: ObservableObject {
    @Published var themes: [ThemeTag] = []

    func fetchThemes() {
        guard let url = URL(string: "http://localhost:3000/api/v1/themes") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let fetchedThemes = try decoder.decode([ThemeTag].self, from: data)
                    
                    DispatchQueue.main.async {
                        self.themes = fetchedThemes
                    }
                } catch {
                    print("Ошибка декодирования тем: \(error)")
                }
            } else if let error = error {
                print("Ошибка сети (темы): \(error)")
            }
        }.resume()
    }
}

class ProfileFetcher: ObservableObject {
    @Published var profiles: [Profile] = []

    func fetchProfiles() {
        guard let url = URL(string: "http://localhost:3000/api/v1/profiles") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let fetchedProfiles = try decoder.decode([Profile].self, from: data)
                    
                    DispatchQueue.main.async {
                        self.profiles = fetchedProfiles
                    }
                } catch {
                    print("Ошибка декодирования профилей: \(error)")
                }
            } else if let error = error {
                print("Ошибка сети (профили): \(error)")
            }
        }.resume()
    }
}
