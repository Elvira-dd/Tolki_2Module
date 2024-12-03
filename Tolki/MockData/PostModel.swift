//
//  ProgramModel.swift
//  Tolki
//
//  Created by Эльвира on 02.12.2024.
//

import SwiftUI

struct Post: Identifiable, Decodable {
    var id: Int
    var title: String
    var text: String
    var user_name: String
    var issue_name: String
    var podcast_name: String
    var hashtag: String
    var tags: [String]
}

