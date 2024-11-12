//
//  MainView.swift
//  Tolki
//
//  Created by Эльвира on 11.11.2024.
//

import SwiftUI

struct MainView: View {
    @State private var cards: [Card] = [
        Card(title: "Card 1", description: "Description for card 1", tags: ["Tag1", "Tag2"]),
        Card(title: "Card 2", description: "Description for card 2", tags: ["Tag3"]),
        Card(title: "Card 3", description: "Description for card 3", tags: ["Tag1"]),
        Card(title: "Card 4", description: "Description for card 4", tags: ["Tag2", "Tag3"]),
        Card(title: "Card 5", description: "Description for card 5", tags: ["Tag5", "Tag3"])
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

    var body: some View {
        NavigationView {
            VStack {
                // Селектор фильтра по тегам
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
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10)
                    .padding(.horizontal)

                // Список карточек
                List {
                    ForEach(filteredCards) { card in
                        CardView(card: card)
                            .onTapGesture {
                                // Открытие подробного просмотра карточки
                            }
                    }
                    .onDelete(perform: deleteCard)
                }
                .listStyle(PlainListStyle())
            }
            .navigationBarTitle("Cards")
            .navigationBarItems(trailing: Button(action: {
                showModal.toggle()
            }) {
                Image(systemName: "plus")
            })
            .sheet(isPresented: $showModal) {
                AddCardView(cards: $cards)
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
}
