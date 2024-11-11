//
//  ContentView.swift
//  Tolki
//
//  Created by Эльвира on 11.11.2024.
//
import SwiftUI

struct ContentView: View {
    let pages = [
        OnboardingData(image: "img1", title: "Добро пожаловать!", description: "Откройте для себя рецензии на книги"),
        OnboardingData(image: "img2", title: "Находите подкасты", description: "Ищите что послушать по жанрам, авторам и ключевым словам"),
        OnboardingData(image: "img3", title: "Поделитесь мнением", description: "Оставляйте свои рецензии и делитесь ими с другими")
    ]
    
    @State private var currentPage = 0
    @State private var hasOnboarded = false
    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false  // Состояние авторизации
    
    var body: some View {
        VStack {
            if hasOnboarded {
                LoginView(isLoggedIn: $isLoggedIn)  // Показываем экран авторизации
            } else {
                TabView(selection: $currentPage) {
                    ForEach(pages.indices, id: \.self) { index in
                        OnboardingView(data: pages[index])
                            .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle())
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                
                HStack {
                    if currentPage > 0 {
                        Button("Назад") {
                            currentPage -= 1
                        }
                        .padding(.horizontal)
                    }
                    
                    Spacer()
                    
                    if currentPage < pages.count - 1 {
                        Button("Далее") {
                            currentPage += 1
                        }
                        .padding(.horizontal)
                    } else {
                        Button("Начать") {
                            hasOnboarded = true  // Переход к экрану авторизации
                        }
                        .padding(.horizontal)
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    ContentView()
}
