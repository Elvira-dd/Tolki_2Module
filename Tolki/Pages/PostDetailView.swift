//
//  IssueDateilView.swift
//  Cry
//
//  Created by Эльвира on 27.03.2025.
//

import SwiftUI
import SwiftUI

struct PostDetailView: View {
    var post: Post
    @State private var posts: [Post] = []
    
    var relatedPosts: [Post] {
        posts.filter { $0.podcastId == post.podcastId && $0.id != post.id }
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                
                
                Text(post.title)
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(Color("MainLight"))
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(post.createdAt)
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(Color("MainLight"))
                    .multilineTextAlignment(.leading)
                    .padding(.bottom, 12)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack(spacing: 12) {
                    Image("IconLike")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                    
                    Image("IconDislike")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                    Image("IconShare")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                }
                .padding(.top, 16)
                
                
                Text("154 комментария")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(Color("MainLight"))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                if post.comments.isEmpty {
                    Text("Нет комментариев")
                        .foregroundColor(.gray)
                } else {
                    ForEach(post.comments) { comment in
                        VStack(alignment: .leading) {
                            HStack(alignment: .center) {
                                Image("ProfileAvatar")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 32, height: 32)
                                    .cornerRadius(50)
                                
                                VStack(alignment: .leading) {
                                    Text(comment.userName)
                                        .font(.system(size: 14, weight: .medium))
                                        .foregroundColor(Color("MainLight"))
                                    
                                    Text("Знаток подкастов 8 уровня")
                                        .font(.system(size: 12, weight: .regular))
                                        .foregroundColor(Color("MainLight"))
                                }
                                
                                Spacer()
                                
                                Text(comment.createdAt)
                                    .font(.system(size: 12, weight: .regular))
                                    .foregroundColor(Color("MainLight"))
                            }
                            
                            Text(comment.content)
                                .font(.system(size: 14, weight: .regular))
                                .foregroundColor(Color("MainLight"))
                                .multilineTextAlignment(.leading)
                                .padding(.top, 8)
                            
                            HStack(spacing: 12) {
                                Image("IconLike")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                                
                                Image("IconDislike")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                            }
                            .padding(.top, 16)
                        }
                        .padding(16)
                        .background(Color("MainLight4"))
                        .cornerRadius(8)
                        .padding(.top, 24)
                    }
                }
                
                
                
        
            
            
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(false)  // Отключение скрытия навигационной панели
        .background(Color("Background"))
        .onAppear {
            // Установим черный фон для NavigationBar
            UINavigationBar.appearance().barTintColor = UIColor.black
            UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
            UINavigationBar.appearance().tintColor = .white // для кнопок и стрелок
        }
        .frame(width:.infinity)
        
    }
    
        .padding(.horizontal, 16)
        .background(Color("Background"))
    
    
}
}


#Preview {
    PodcastView()
    
}
