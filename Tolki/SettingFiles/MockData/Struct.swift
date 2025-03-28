//
//  Struct.swift
//  Tolki
//
//  Created by Эльвира on 24.12.2024.
//

import Foundation

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



// Структура для подкаста
struct Podcast: Identifiable, Codable {
    var id: Int
    var name: String
    var description: String
    var createdAt: String
    var averageRating: String
    var coverURL: String
    var issue: [Issue]
    var posts: [Post]
    var authors: [Author]
    var themes: [Theme]
    
    // Указываем, как ключи из JSON соответствуют нашим свойствам
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case createdAt = "created_at" // соответствие между JSON и структурой
        case averageRating = "average_rating"
        case coverURL = "cover_url"
        case issue
        case posts
        case authors
        case themes
    }
}
struct Author: Identifiable, Codable {
    var id: Int
    var name: String
    var avatarURL: String
    
    // Указываем, как ключи из JSON соответствуют нашим свойствам
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case avatarURL = "avatar_url"
    }
    init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            // Используем decodeIfPresent для безопасного декодирования
            self.id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 10  // Установим дефолтное значение
            self.name = try container.decode(String.self, forKey: .name)
            self.avatarURL = try container.decode(String.self, forKey: .avatarURL)
        }
    
}


struct Post: Identifiable, Codable {
    var id: Int
    var title: String
    var content: String
    var createdAt: String
    var podcastId: Int
    var comments: [Comment]

    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case content
        case createdAt = "created_at" // соответствие между JSON и структурой
        case podcastId = "podcast_id"
        case comments
      
    }

}

// Структура для выпуска
struct Issue: Identifiable, Codable {
    var id: Int
    var name: String
    var description: String
    var createdAt: String
    var podcastId: Int
    var coverURL: String
    var comments: [Comment]
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case createdAt = "created_at" // соответствие между JSON и структурой
        case podcastId = "podcast_id"
        case coverURL = "cover_url"
        case comments
    }
}

struct Comment: Identifiable, Codable {
    var id: Int
    let commentable_type: String?
    let commentable_id: Int?
    var userId: Int
    var content: String
    var userName: String
    var createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case content
        case userName = "user_name"
        case createdAt = "created_at"
        case commentable_type
        case commentable_id
    }
}

struct Theme: Identifiable, Codable {
    var id: Int?
    var name: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
}

// Models/UserProfile.swift
struct AuthResponse: Codable {
    let messages: String
    let isSuccess: Bool
    let jwt: String
    
    enum CodingKeys: String, CodingKey {
        case messages
        case isSuccess = "is_success"
        case jwt
    }
}

struct UserProfile: Codable {
    let email: String
    let profile: ProfileDetails
    
    struct ProfileDetails: Codable {
        let name: String
        let bio: String
        let level: String
    }
}
