//
//  MainView.swift
//  Tolki
//
//  Created by Эльвира on 11.11.2024.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var themeManager: ThemeManager
    var body: some View {
        VStack {
            PostsView()
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(ThemeManager())
}
