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
    @State private var selectedTag: String = "Подписки"
    @State private var searchText: String = ""
    
    // Получаем уникальные теги из всех карточек
    var uniqueTags: [String] {
        var tags = posts.flatMap { $0.tags }
        return Array(Set(tags)).sorted()
    }
    
    // Фильтрация карточек по тегу и поисковому запросу
    var filteredPosts: [Post] {
        let filteredByTag = selectedTag == "Подписки" ? posts : posts.filter { $0.tags.contains(selectedTag) }
        if searchText.isEmpty {
            return filteredByTag
        } else {
            return filteredByTag.filter {
                $0.title.contains(searchText) || $0.text.contains(searchText)
            }
        }
    }
    
    // Два столбца для сетки
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            ZStack {
                // Фон экрана
                themeManager.currentTheme.backgroundColor
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(uniqueTags, id: \.self) { tag in
                                Text(tag)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 8)
                                    .background(selectedTag == tag ? Color(themeManager.currentTheme.buttonColor) : Color(themeManager.currentTheme.secondaryBackgroundColor))
                                    .foregroundColor(Color(themeManager.currentTheme.textColor))
                                    .cornerRadius(10)
                                    .onTapGesture {
                                        selectedTag = tag
                                    }
                            }
                        }
                        .padding()
                    }
                    
                    // Поле поиска
                    TextField("Что ищем?", text: $searchText)
                        .padding()
                        .foregroundColor(themeManager.currentTheme.textColor)
                        .background(themeManager.currentTheme.secondaryBackgroundColor)
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .padding(.bottom, 20)
                    
                    // Сетка карточек
                    ScrollView {
                        VStack(alignment: .leading, spacing: 20) {
                            ForEach(filteredPosts) { post in
                                NavigationLink(destination: PostDetailView(post: post).environmentObject(themeManager)) {
                                    VStack(alignment: .leading) {
                                        Text(post.user_name)
                                            .font(.subheadline)
                                            .lineLimit(1)
                                            .fixedSize(horizontal: false, vertical: true)
                                            .padding(.top, 5)
                                            .foregroundColor(themeManager.currentTheme.secondaryTextColor)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                        Text(post.title)
                                            .font(.headline)
                                            .foregroundColor(themeManager.currentTheme.secondaryTextColor)
                                            .multilineTextAlignment(.leading)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                        
                                        Text(post.text)
                                            .font(.subheadline)
                                            .lineLimit(2)
                                            .multilineTextAlignment(.leading)
                                            .fixedSize(horizontal: false, vertical: true)
                                            .padding(.top, 5)
                                            .foregroundColor(themeManager.currentTheme.secondaryTextColor)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                        
                                        Text(post.podcast_name + " — " + post.issue_name )
                                            .font(.subheadline)
                                            .lineLimit(1)
                                            .multilineTextAlignment(.leading)
                                            .fixedSize(horizontal: false, vertical: true)
                                            .padding(.top, 5)
                                            .foregroundColor(themeManager.currentTheme.secondaryTextColor)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                        
                                        HStack {
                                            Text(post.hashtag)
                                                .font(.caption)
                                                .padding(5)
                                            
                                                .cornerRadius(5)
                                                .foregroundColor(themeManager.currentTheme.textColor)
                                                .background(themeManager.currentTheme.buttonColor)
                                            
                                        }
                                        
                                        .padding(.top, 5)
                                        
                                    }
                                    //конец встака
                                    .padding()
                                    .background(themeManager.currentTheme.secondaryBackgroundColor)
                                    .cornerRadius(10)
                                    .shadow(radius: 5)
                                }
                                //Конец Navigation
                            }
                        }
                        .padding(.horizontal)
                    }
                    .background(themeManager.currentTheme.backgroundColor)
                }
                .navigationBarTitle("Рецензии")
                .navigationBarItems(trailing: Button(action: {
                    showModal.toggle()
                }) {
                    Image(systemName: "plus")
                        .foregroundColor(themeManager.currentTheme.textColor)
                })
            }
        }
        .sheet(isPresented: $showModal) {
            AddPostView(posts: $posts)
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
