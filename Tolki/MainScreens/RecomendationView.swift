//
//  RecomendationView.swift
//  Tolki
//
//  Created by Эльвира on 10.02.2025.
//

import SwiftUI

struct RecomendView: View {
    var body: some View {
        ZStack {
            Color.red.ignoresSafeArea()
            Text("Рекомендации").foregroundColor(.white).font(.largeTitle)
        }
    }
}

struct RecomendView_Previews: PreviewProvider {
    static var previews: some View {
        RecomendView()

            .environmentObject(PodcastFetcher()) // Обеспечиваем доступ к данным для превью
    }
}

