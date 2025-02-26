import SwiftUI



struct MainView: View {
    @StateObject var dataFetcher = PodcastFetcher() // Инициализируем PodcastFetcher
    @State private var selectedTab = 0
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // Верхний переключатель
                HStack {
                    Text("главная")
                        .foregroundColor(selectedTab == 0 ? Color.green : Color.gray) // Заменяем цвета на стандартные
                        .onTapGesture { selectedTab = 0 }
                    
                    Text("рекомендации")
                        .foregroundColor(selectedTab == 1 ? Color.green : Color.gray) // Заменяем цвета на стандартные
                        .onTapGesture { selectedTab = 1 }
                }
                .padding()
                .frame(maxWidth: .infinity)
                
                // Контент с Spacer() для правильного размещения
                Spacer()
                if selectedTab == 0 {
                    TopView()
                } else {
                    RecomendView()
                }
                Spacer()
            }
            .edgesIgnoringSafeArea(.all)
            .background(Color(.systemBackground)) // Используем стандартный цвет фона
        }
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(PodcastFetcher()) // Обеспечиваем доступ к данным для превью
    }
}
