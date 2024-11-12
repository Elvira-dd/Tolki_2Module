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
                    Image(systemName: "list.bullet")
                    Text("Cards")
                }
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person.circle")
                    Text("Profile")
                }
        }
    }
}

#Preview {
    MainTabView()
}
