//
//  Struct.swift
//  Tolki
//
//  Created by Эльвира on 24.12.2024.
//

import Foundation

struct Posts: Codable, Identifiable, Hashable {
    let id: Int
    let title: String
    let content: String?
    let date: String?
    let link: String
    let hashtag: String
    let createdAt: String?
    let url: String
    let comments: [Comment]? // Массив комментариев

    // Сопоставление ключей для кодирования и декодирования JSON
    enum CodingKeys: String, CodingKey {
        case id, title, content, date, link, hashtag, url, comments
        case createdAt = "created_at"
    }
}
struct Comment: Codable, Identifiable, Hashable {
    let id: UUID? // UUID автоматически генерируется
    let content: String
}

// Модель для подкастов
struct Podcast: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let description: String
    let cover: String
    let createdAt: String
    let averageRating: String
    let url: String

    // Сопоставление ключей для кодирования и декодирования JSON
    enum CodingKeys: String, CodingKey {
        case id, name, description, cover, url
        case createdAt = "created_at"
        case averageRating = "average_rating"
    }
}
