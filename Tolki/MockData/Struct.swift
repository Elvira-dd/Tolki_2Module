//
//  Struct.swift
//  Tolki
//
//  Created by Эльвира on 24.12.2024.
//

import Foundation
import Foundation

struct Posts: Identifiable, Hashable, Codable {
    var id: Int?
    var title: String
    var content: String?
    var isCommentsOpen: Bool
    var link: String
    var hashtag: String
    var createdAt: String?
    var comments: [Comment]?

    // Реализация hash(into:) для соответствия протоколу Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(title)
        hasher.combine(content)
        hasher.combine(isCommentsOpen)
        hasher.combine(link)
        hasher.combine(hashtag)
        hasher.combine(createdAt)
    }

    // Реализация equatable для соответствия протоколу Hashable
    static func == (lhs: Posts, rhs: Posts) -> Bool {
        return lhs.id == rhs.id &&
               lhs.title == rhs.title &&
               lhs.content == rhs.content &&
               lhs.isCommentsOpen == rhs.isCommentsOpen &&
               lhs.link == rhs.link &&
               lhs.hashtag == rhs.hashtag &&
               lhs.createdAt == rhs.createdAt
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
