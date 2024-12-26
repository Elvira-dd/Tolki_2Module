//
//  PostPage.swift
//  Tolki
//
//  Created by Эльвира on 24.12.2024.
//


import SwiftUI
// Новости
struct NewsCard: View {
    let post: Posts

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(post.title)
                .font(.headline)
                .foregroundColor(.primary)
                .lineLimit(2)

            if let content = post.content {
                Text(content)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(3)
            }

            if let createdAt = post.createdAt {
                Text(createdAt)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .background(Color.black.opacity(0.05))
        .cornerRadius(12)
        .frame(width: 300)
    }
}

// Шаблон для секции
struct SectionView<Item: Hashable, Content: View>: View {
    let title: String
    let items: [Item]
    let content: (Item) -> Content
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .padding(.bottom, 5)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(items, id: \.self) { item in
                        content(item)
                    }
                }
            }
        }
    }
}

struct NewsSectionView: View {
    let posts: [Posts]

    var body: some View {
        ScrollView {
            SectionView(title: "Посты", items: posts) { post in
                NavigationLink(destination: PostDetailView(post: post)) {
                    NewsCard(post: post)
                }
            }
            .padding()
        }
    }
}

struct PostsView: View {
    @StateObject private var fetcher = DataFetcher()
    @State private var currentPage: Int = 0

    var body: some View {
        NavigationStack {
            TabView(selection: $currentPage) {
                NewsSectionView(posts: fetcher.posts)
                    .tag(0)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
            .onAppear {
                fetcher.fetchData()
            }
        }
    }
}

struct PostsView_Previews: PreviewProvider {
    static var previews: some View {
        PostsView()
    }
}




