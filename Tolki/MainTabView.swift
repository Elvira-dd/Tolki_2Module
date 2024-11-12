//
//  MainTabView.swift
//  Tolki
//
//  Created by Эльвира on 12.11.2024.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    var body: some View {
        TabView {
            MainView()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Cards")
                        .foregroundColor(themeManager.currentTheme.textColor)
                }
            ProfileView()
                .tabItem {
                    Image(systemName: "person.circle")
                    Text("Profile")
                        .foregroundColor(themeManager.currentTheme.textColor)
                }
            SettingsView()
                .tabItem {
                    Image(systemName: "person.circle")
                    Text("Setting")
                        .foregroundColor(themeManager.currentTheme.textColor)
                }
        }
        .background(themeManager.currentTheme.backgroundColor)
    }
}


#Preview {
    MainTabView()
        .environmentObject(ThemeManager())
}
