//
//  Struct.swift
//  Tolki
//
//  Created by Эльвира on 24.12.2024.
//

import Foundation

struct Posts: Identifiable, Hashable, Codable {
    var id: Int
        var title: String
        var content: String?
        var isCommentsOpen: Bool?
        var link: String
        var hashtag: String
        var createdAt: String?
        var comments: [Comment]?
        var issueId: Int?
    
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
    
    // Сопоставление полей JSON с моделью
    enum CodingKeys: String, CodingKey {
           case id
           case title
           case content
           case isCommentsOpen = "is_comments_open"
           case link
           case hashtag
           case createdAt = "created_at"
           case comments
           case issueId = "issue_id"
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

// Модель для выпусков (Issue)
struct Issue: Codable, Identifiable {
    let id: Int
    let name: String
    let link: String
    let cover: String
    let createdAt: String
    let podcastId: Int
    let url: String

    enum CodingKeys: String, CodingKey {
        case id, name, link, cover, url
        case createdAt = "created_at"
        case podcastId = "podcast_id"
    }
}

struct ThemeTag: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let description: String
    let cover: String
    let createdAt: String

    enum CodingKeys: String, CodingKey {
        case id, name, description, cover
        case createdAt = "created_at"
    }
}

struct Profile: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let bio: String
    let avatar: String
    let level: String
    let email: String // Email пользователя

    enum CodingKeys: String, CodingKey {
        case id, name, bio, avatar, level, email
    }
}
