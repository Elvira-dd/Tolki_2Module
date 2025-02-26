//
//  MainTabView.swift
//  Tolki
//
//  Created by Эльвира on 12.11.2024.
//

import SwiftUI

struct MainTabView: View {
 

    var body: some View {
        TabView {
            MainView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Главная")
                }
            
            PodcastView()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Подкасты")
                }
            
            CreatePostView()
                .tabItem {
                    Image(systemName: "plus")
                    Text("Новый пост")
                }
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person.circle")
                    Text("Профиль")
                }

            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Настройки")
                }
        }
        .background(Color.background)
        .ignoresSafeArea()
    }
}

#Preview {
   
    MainTabView()
}
