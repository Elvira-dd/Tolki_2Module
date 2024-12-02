//
//  MainView.swift
//  Tolki
//
//  Created by Эльвира on 11.11.2024.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @State private var posts: [Post] = load("postsData.json")
    @State private var showModal = false
    @State private var selectedTag: String = "All"
    @State private var searchText: String = ""
    
    // Получаем уникальные теги из всех карточек
    var uniqueTags: [String] {
        var tags = posts.flatMap { $0.tags }
        tags.append("All")
        return Array(Set(tags)).sorted()
    }
    
    // Фильтрация карточек по тегу и поисковому запросу
    var filteredPosts: [Post] {
        let filteredByTag = selectedTag == "All" ? posts : posts.filter { $0.tags.contains(selectedTag) }
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
                            ForEach(filteredPosts) { post in
                                
                                VStack(alignment: .leading) {
                                    Text(post.title)
                                        .font(.headline)
                                        .foregroundColor(themeManager.currentTheme.secondaryTextColor)  // Цвет текста
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    Text(post.description)
                                        .font(.subheadline)
                                        .lineLimit(3)
                                        .fixedSize(horizontal: false, vertical: true)
                                        .padding(.top, 5)
                                        .foregroundColor(themeManager.currentTheme.secondaryTextColor)  // Цвет текста
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    
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
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.top, 5)
                                }
                                .frame(width: UIScreen.main.bounds.width / 2 - 60)
                                
                                .padding()
                                .background(themeManager.currentTheme.secondaryBackgroundColor)  // Цвет фона карточки
                                .cornerRadius(10)
                                .shadow(radius: 5)
                                    
                                
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
                    AddPostView(posts: $posts)
                }
            }
        }
    }

    // Функция для удаления карточки
    mutating func deletePost(at offsets: IndexSet) {
        posts.remove(atOffsets: offsets)
    }
}

#Preview {
    HomeView()
        .environmentObject(ThemeManager())
}
