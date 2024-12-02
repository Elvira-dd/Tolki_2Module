//
//  DataLoad.swift
//  Tolki
//
//  Created by Эльвира on 02.12.2024.
//

import SwiftUI

var posts: [Post] = load("postsData.json")

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
        print("Data loaded successfully: \(data)")
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        print("Parsing error: \(error)")
        fatalError("Couldn't parse \(filename) as \(T.self).")
    }
}

