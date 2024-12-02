//
//  MainView.swift
//  Tolki
//
//  Created by Эльвира on 11.11.2024.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @State private var cards: [Card] = [
        Card(title: "Card 1", description: "Description for card 1. This is the most recognasyble podcast", tags: ["Tag1", "Tag2"]),
        Card(title: "Card 2", description: "Description for card 2. This is the most recognasyble podcast", tags: ["Tag3"]),
        Card(title: "Card 3", description: "Description for card 3. This is the most recognasyble podcast", tags: ["Tag1"]),
        Card(title: "Card 4", description: "Description for card 4. This is the most recognasyble podcast", tags: ["Tag2", "Tag3"]),
        Card(title: "Card 5", description: "Description for card 2. This is the most recognasyble podcast", tags: ["Tag5", "Tag3"]),
        Card(title: "Card 5", description: "Description for card 2. This is the most recognasyble podcast", tags: ["Tag5", "Tag3"]),
        Card(title: "Card 5", description: "Description for card 2. This is the most recognasyble podcast", tags: ["Tag5", "Tag3"]),
        Card(title: "Card 5", description: "Description for card 2. This is the most recognasyble podcast", tags: ["Tag5", "Tag3"]),
        Card(title: "Card 5", description: "Description for card 2. This is the most recognasyble podcast", tags: ["Tag5", "Tag3"]),
        Card(title: "Card 5", description: "Description for card 2. This is the most recognasyble podcast", tags: ["Tag5", "Tag3"]),
    ]
    @State private var showModal = false
    @State private var selectedTag: String = "All"
    @State private var searchText: String = ""
    
    // Получаем уникальные теги из всех карточек
    var uniqueTags: [String] {
        var tags = cards.flatMap { $0.tags }
        tags.append("All")
        return Array(Set(tags)).sorted()
    }
    
    // Фильтрация карточек по тегу и поисковому запросу
    var filteredCards: [Card] {
        let filteredByTag = selectedTag == "All" ? cards : cards.filter { $0.tags.contains(selectedTag) }
        if searchText.isEmpty {
            return filteredByTag
        } else {
            return filteredByTag.filter {
                $0.title.contains(searchText) || $0.description.contains(searchText)
            }
        }
    }
    
    // Два столбца для сетки
    let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        NavigationView {
            ZStack {
                // Задаем фон для всего экрана
                themeManager.currentTheme.backgroundColor
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Picker("Filter by Tag", selection: $selectedTag) {
                        ForEach(uniqueTags, id: \.self) { tag in
                            Text(tag).tag(tag)
                            
                        }
                    }
                    
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    
                    // Поле поиска
                    TextField("Search", text: $searchText)
                        .padding()
                        .foregroundColor(themeManager.currentTheme.textColor)  // Цвет текста
                        .background(themeManager.currentTheme.secondaryBackgroundColor)  // Цвет фона
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .padding(.bottom, 20)
                    
                    // Сетка для карточек
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(filteredCards) { card in
                                CardView(card: card)
                                    .onTapGesture {
                                        // Открытие подробного просмотра карточки
                                    }
                            }
                        }
                        .padding(.horizontal)
                    }
                    .background(themeManager.currentTheme.backgroundColor)
                }
                .navigationBarTitle("Cards")
                .foregroundColor(themeManager.currentTheme.textColor)
                .background(themeManager.currentTheme.backgroundColor)
                .navigationBarItems(trailing: Button(action: {
                    showModal.toggle()
                }) {
                    Image(systemName: "plus")
                        .foregroundColor(themeManager.currentTheme.textColor)
                })
                .sheet(isPresented: $showModal) {
                    AddCardView(cards: $cards)
                }
            }
        }
    }

    // Функция для удаления карточки
    func deleteCard(at offsets: IndexSet) {
        cards.remove(atOffsets: offsets)
    }
}

#Preview {
    MainView()
        .environmentObject(ThemeManager())
}
