//
//  DataLoad.swift
//  Tolki
//
//  Created by Эльвира on 02.12.2024.
//

import SwiftUI

var posts: [Post] = load("postsData.json")

func load<T: Decodable>(_ filename: String) -> T {
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
        print("Файл \(filename) не найден.")
        return [] as! T
    }

    do {
        let data = try Data(contentsOf: file)
        return try JSONDecoder().decode(T.self, from: data)
    } catch {
        print("Ошибка при загрузке или парсинге файла \(filename): \(error)")
        return [] as! T
    }
}
