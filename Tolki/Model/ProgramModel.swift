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
    var description: String
    var tags: [String]
}

