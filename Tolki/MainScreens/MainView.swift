import SwiftUI

struct MainView: View {
    @StateObject var dataFetcher = PodcastFetcher() // Инициализируем PodcastFetcher
    @State private var selectedTab = 0
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                HStack {
                    Text("главная")
                        .foregroundColor(selectedTab == 0 ? Color(.mainGreen) : Color(.mainLight2))
                        .onTapGesture { selectedTab = 0 }
                    
                    Text("рекомендации")
                        .foregroundColor(selectedTab == 1 ? Color(.mainGreen) : Color(.mainLight2))
                        .onTapGesture { selectedTab = 1 }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color(.background)) // Устанавливаем черный фон для заголовка
                
                // Контент с Spacer() для правильного размещения
                if selectedTab == 0 {
                    TopView()
                } else {
                    RecomendView()
                }
                Spacer()
            }
            .padding(.top, 60) // Добавляем отступ сверху для расположения ниже динамического острова
        }
        .edgesIgnoringSafeArea(.all)
        .background(Color(.background)) // Устанавливаем черный фон для всего ScrollView
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(PodcastFetcher())
    }
}
