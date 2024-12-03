//
//  PostDetailView.swift
//  Tolki
//
//  Created by Эльвира on 03.12.2024.
//

import SwiftUI

struct PostDetailView: View {
    var post: Post
    @EnvironmentObject var themeManager: ThemeManager

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(post.title)
                .font(.largeTitle)
                .bold()
                .foregroundColor(themeManager.currentTheme.textColor)

            Text(post.text)
                .font(.body)
                .foregroundColor(themeManager.currentTheme.secondaryTextColor)

            HStack {
                ForEach(post.tags, id: \.self) { tag in
                    Text(tag)
                        .font(.caption)
                        .padding(5)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(5)
                        .foregroundColor(themeManager.currentTheme.textColor)
                        .background(themeManager.currentTheme.buttonColor)
                }
            }

            Spacer() // Заполнить свободное пространство
        }
        .padding()
        .background(themeManager.currentTheme.backgroundColor)
        .navigationBarTitle("Детали", displayMode: .inline) // Заголовок с кнопкой "Назад"
    }
}
