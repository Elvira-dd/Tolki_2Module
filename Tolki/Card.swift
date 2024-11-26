//
//  Card.swift
//  Tolki
//
//  Created by Эльвира on 12.11.2024.
//

import SwiftUI

struct CardView: View {
    var card: Card
    @EnvironmentObject var themeManager: ThemeManager
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(card.title)
                .font(.headline)
                .foregroundColor(themeManager.currentTheme.secondaryTextColor)  // Цвет текста
            Text(card.description)
                .font(.subheadline)
                .lineLimit(2)
                .padding(.top, 5)
                .foregroundColor(themeManager.currentTheme.secondaryTextColor)  // Цвет текста
            
            HStack {
                ForEach(card.tags, id: \.self) { tag in
                    Text(tag)
                        .font(.caption)
                        .padding(5)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(5)
                        .foregroundColor(themeManager.currentTheme.textColor)  // Цвет текста для тегов
                }
            }
            .padding(.top, 5)
        }
        .padding()
        .background(themeManager.currentTheme.buttonColor)  // Цвет фона карточки
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

#Preview {
    MainView()
        .environmentObject(ThemeManager())
    
}
