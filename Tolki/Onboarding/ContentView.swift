import SwiftUI

struct ContentView: View {
    @EnvironmentObject var themeManager: ThemeManager
    let pages = [
        OnboardingData(image: "img1", title: "Добро пожаловать!", description: "Откройте для себя рецензии на подкасты"),
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
                .foregroundColor(themeManager.currentTheme.buttonTextColor)
                .tabViewStyle(PageTabViewStyle())
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                
                HStack {
                    if currentPage > 0 {
                        Button("Назад") {
                            currentPage -= 1
                        }
                        .foregroundColor(themeManager.currentTheme.buttonTextColor)
                        .padding(.horizontal)
                    }
                    
                    Spacer()
                    
                    if currentPage < pages.count - 1 {
                        Button("Далее") {
                            currentPage += 1
                        }
                        .foregroundColor(themeManager.currentTheme.buttonTextColor)
                        .padding(.horizontal)
                    } else {
                        Button("Начать") {
                            hasOnboarded = true  // Переход к экрану авторизации
                        }
                        .foregroundColor(themeManager.currentTheme.buttonTextColor)
                        .padding(.horizontal)
                    }
                }
                .padding()
            }
        }
        .background(themeManager.currentTheme.backgroundColor)  // Устанавливаем фон всего приложения
    }
}

#Preview {
    ContentView()
        .environmentObject(ThemeManager())  // Подключаем ThemeManager
}
