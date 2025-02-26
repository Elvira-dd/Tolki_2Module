//
//  OnboardingView.swift
//  Tolki
//
//  Created by Эльвира on 11.11.2024.
//

import Foundation
import SwiftUI
 
// Модель данных для экрана онбординга
struct OnboardingData: Identifiable, Hashable {
    var id = UUID()
    var image: String
    var title: String
    var description: String
}

// Представление одного экрана онбординга
struct OnboardingView: View {
    var data: OnboardingData

    var body: some View {
        VStack(spacing: 20) {
            Image(data.image)
                .resizable()
                .scaledToFit()
                .frame(height: 200)
            Text(data.title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .foregroundColor(Color.accentColor)
            Text(data.description)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .foregroundColor(Color.accentColor)
        }
        .padding()
        .background(Color.background)
    }
}

