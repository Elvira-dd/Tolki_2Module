//
//  AddCardView.swift
//  Tolki
//
//  Created by Эльвира on 12.11.2024.
//

import SwiftUI

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


