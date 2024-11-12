//
//  Card.swift
//  Tolki
//
//  Created by Эльвира on 12.11.2024.
//

import SwiftUI

import SwiftUI

struct CardView: View {
    @EnvironmentObject var themeManager: ThemeManager // Подключение ThemeManager
    var card: Card
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(card.title)
                .font(.headline)
                .foregroundColor(themeManager.currentTheme.textColor) // Установка цвета текста
            Text(card.description)
                .font(.subheadline)
                .lineLimit(2)
                .foregroundColor(themeManager.currentTheme.textColor) // Установка цвета текста
                .padding(.top, 5)
            HStack {
                ForEach(card.tags, id: \.self) { tag in
                    Text(tag)
                        .font(.caption)
                        .padding(5)
                        .background(Color.gray.opacity(0.2))
                        .foregroundColor(themeManager.currentTheme.textColor) // Установка цвета текста
                        .cornerRadius(5)
                }
            }
            .padding(.top, 5)
        }
        .padding()
        .background(themeManager.currentTheme.backgroundColor) // Установка фона
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}


struct Card: Identifiable, Hashable {
    var id = UUID()
    var title: String
    var description: String
    var tags: [String]
}
