//
//  AddCardView.swift
//  Tolki
//
//  Created by Эльвира on 12.11.2024.
//

import SwiftUI

struct AddCardView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @Binding var cards: [Card]
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var tags: String = ""
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Card Information").foregroundColor(themeManager.currentTheme.textColor)) {
                    TextField("Title", text: $title)
                        .foregroundColor(themeManager.currentTheme.textColor)
                    TextField("Description", text: $description)
                        .foregroundColor(themeManager.currentTheme.textColor)
                    TextField("Tags (comma separated)", text: $tags)
                        .foregroundColor(themeManager.currentTheme.textColor)
                }
                Button("Add Card") {
                    let tagList = tags.split(separator: ",").map { String($0).trimmingCharacters(in: .whitespaces) }
                    cards.append(Card(title: title, description: description, tags: tagList))
                    presentationMode.wrappedValue.dismiss()
                }
                .foregroundColor(themeManager.currentTheme.buttonTextColor)
                .background(themeManager.currentTheme.buttonColor)
                .cornerRadius(8)
            }
            .background(themeManager.currentTheme.backgroundColor)
            .navigationBarTitle("Add Card")
            .navigationBarItems(trailing: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}
