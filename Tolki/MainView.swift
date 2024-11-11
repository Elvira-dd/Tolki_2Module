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
        Card(title: "Card 4", description: "Description for card 4", tags: ["Tag5", "Tag3"])
    ]
    
    @State private var showModal = false
    @State private var selectedTag: String = "All"
    
    // Получаем уникальные теги из всех карточек
    var uniqueTags: [String] {
        var tags = cards.flatMap { $0.tags }
        tags.append("All")  // Добавляем "All" для отображения всех карточек
        return Array(Set(tags)).sorted() // Убираем дубликаты и сортируем
    }
    
    // Фильтрация карточек по выбранному тегу
    var filteredCards: [Card] {
        if selectedTag == "All" {
            return cards
        } else {
            return cards.filter { $0.tags.contains(selectedTag) }
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
                
                // Список карточек, отфильтрованных по выбранному тегу
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

struct CardView: View {
    var card: Card
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(card.title)
                .font(.headline)
            Text(card.description)
                .font(.subheadline)
                .lineLimit(2)
                .padding(.top, 5)
            HStack {
                ForEach(card.tags, id: \.self) { tag in
                    Text(tag)
                        .font(.caption)
                        .padding(5)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(5)
                }
            }
            .padding(.top, 5)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

struct AddCardView: View {
    @Binding var cards: [Card]
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var tags: String = ""
    
    // Для закрытия модального окна
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Card Information")) {
                    TextField("Title", text: $title)
                    TextField("Description", text: $description)
                    TextField("Tags (comma separated)", text: $tags)
                }
                
                Button("Add Card") {
                    let tagList = tags.split(separator: ",").map {
                        String($0).trimmingCharacters(in: .whitespaces)
                    }
                    let newCard = Card(title: title, description: description, tags: tagList)
                    cards.append(newCard)
                    
                    // Закрыть модальное окно после добавления карточки
                    presentationMode.wrappedValue.dismiss()
                }
            }
            .navigationBarTitle("Add Card")
            .navigationBarItems(trailing: Button("Cancel") {
                            // Закрытие модального окна при нажатии на Cancel
                            presentationMode.wrappedValue.dismiss()
                        })
        }
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
}
