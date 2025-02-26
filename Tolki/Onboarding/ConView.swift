import SwiftUI

struct ConView: View {
    let pages = [
        OnboardingData(image: "img1", title: "Добро пожаловать!", description: "Откройте для себя рецензии на подкасты"),
        OnboardingData(image: "img2", title: "Находите подкасты", description: "Ищите что послушать по жанрам, авторам и ключевым словам"),
        OnboardingData(image: "img3", title: "Поделитесь мнением", description: "Оставляйте свои рецензии и делитесь ими с другими")
    ]
    
    @State private var currentPage = 0
    @State private var hasOnboarded = false
   
    
    var body: some View {
        VStack {
            if hasOnboarded {
               
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
                        .foregroundColor(Color.blue)
                        .padding(.horizontal)
                    }
                    
                    Spacer()
                    
                    if currentPage < pages.count - 1 {
                        Button("Далее") {
                            currentPage += 1
                        }
                        .foregroundColor(Color.blue)
                        .padding(.horizontal)
                    } else {
                        Button("Начать") {
                            hasOnboarded = true  // Переход к экрану авторизации
                        }
                        .foregroundColor(Color.blue)
                        .padding(.horizontal)
                    }
                }
                .padding()
            }
        }
        .background(Color(.systemBackground))  // Устанавливаем фон всего приложения
    }
}

#Preview {
    ConView()
}
