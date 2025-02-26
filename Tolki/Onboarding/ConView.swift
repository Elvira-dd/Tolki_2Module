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
            ZStack {
                Color(.background)
                    .edgesIgnoringSafeArea(.all)
                
                if hasOnboarded {
                    // Здесь можно добавить переход к экрану авторизации
                } else {
                    VStack {
                        TabView(selection: $currentPage) {
                            ForEach(pages.indices, id: \.self) { index in
                                OnboardingView(data: pages[index])
                                    .tag(index)
                            }
                        }
                        .tabViewStyle(PageTabViewStyle())
                        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                        
                        Spacer() // Занимает пространство, выталкивая кнопки вниз
                        
                        HStack {
                            if currentPage > 0 {
                                Button("Назад") {
                                    currentPage -= 1
                                }
                                .foregroundColor(Color(.mainGreen))
                                .padding()
                            }
                            
                            Spacer()
                            
                            if currentPage < pages.count - 1 {
                                Button("Далее") {
                                    currentPage += 1
                                }
                                .foregroundColor(Color(.mainGreen))
                                .padding()
                            } else {
                                Button("Начать") {
                                    hasOnboarded = true
                                }
                                .foregroundColor(Color(.mainGreen))
                                .padding()
                            }
                        }
                        .padding(.bottom, 30) // Отступ снизу
                    }
                }
            }
        }
        .background(Color(.systemBackground))
    }
}

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
                .foregroundColor(Color(.mainLight))
            Text(data.description)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .foregroundColor(Color(.mainLight2))
        }
        .padding()
        .background(Color.background)
    }
}


#Preview {
    ConView()
}
