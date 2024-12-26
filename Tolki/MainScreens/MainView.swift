import SwiftUI

struct MainView: View {
    @StateObject var dataFetcher = PodcastFetcher() // Инициализируем PodcastFetcher
    @EnvironmentObject var themeManager: ThemeManager

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Первый экран с зелёным фоном и картинкой
                    VStack {
                        Text("Ищи и оставляй отзывы о своих любимых подкастах")
                            .font(.title)
                            .bold()
                            .foregroundColor(Color.white)
                            .padding(.top, 40) // Немного отступа сверху
                            .padding(.all, 20)

                        NavigationLink(destination: CreatePostView()) {
                            Text("Оставить рецензию")
                                .padding()
                                .background(Color.black)
                                .foregroundColor(Color.white)
                                .cornerRadius(10)
                                .padding(.top, 100)
                                .padding(.all, 20)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: 500) // Увеличиваем высоту блока
                    .background(
                        Image("bg_for_main") // Используем изображение из ассетов
                            .resizable() // Делаем изображение растягиваемым
                            .scaledToFill() // Заполняем доступное пространство
                            .clipped() // Обрезаем, если нужно
                    )
                    .cornerRadius(8) // Закругляем углы на 8px
                    .padding()
                    .edgesIgnoringSafeArea([.top, .leading, .trailing]) // Игнорируем сейф зоны по горизонтали и сверху
                    
                    // Топ подкастов
                    VStack(alignment: .leading) {
                        Text("Сегодня в топе эти подкасты")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(themeManager.currentTheme.textColor)
                            .padding(.leading)

                        ForEach(dataFetcher.podcasts.prefix(4), id: \.id) { podcast in
                            NavigationLink(destination: PodcastDetailView(podcast: podcast)) {
                                VStack(alignment: .leading) {
                                    Text(podcast.name)
                                        .font(.title2)
                                        .bold()
                                        .foregroundColor(themeManager.currentTheme.textColor)
                                    Text(podcast.description)
                                        .font(.body)
                                        .foregroundColor(themeManager.currentTheme.secondaryTextColor)
                                }
                                .padding()
                                .background(Color.gray.opacity(0.1)) // MainLight фон
                                .cornerRadius(10)
                                .shadow(radius: 5)
                                .frame(maxWidth: .infinity, alignment: .leading) // Выровнять по левому краю
                            }
                        }
                    }
                    .padding(.top)

                    // Свежие выпуски
                    VStack(alignment: .leading) {
                        Text("Свежие выпуски подкастов")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(themeManager.currentTheme.textColor)
                            .padding(.leading)

                        ForEach(dataFetcher.issues.prefix(6), id: \.id) { issue in
                            VStack(alignment: .leading) {
                                Text(issue.name)
                                    .font(.title2)
                                    .bold()
                                    .foregroundColor(themeManager.currentTheme.textColor)
                                Text("Ссылка: \(issue.link)")
                                    .font(.body)
                                    .foregroundColor(themeManager.currentTheme.secondaryTextColor)
                            }
                            .padding()
                            .background(Color.gray.opacity(0.1)) // MainLight фон
                            .cornerRadius(10)
                            .shadow(radius: 5)
                            .frame(maxWidth: .infinity, alignment: .leading) // Выровнять по левому краю
                        }
                    }
                    .padding(.top)
                }
                .padding()
                .background(themeManager.currentTheme.backgroundColor) // MainLight фон для всей страницы
                .cornerRadius(10)
                .onAppear {
                    dataFetcher.fetchData() // Загружаем данные при запуске
                }
            }
            .navigationBarTitle("Главная", displayMode: .inline)
            .navigationBarItems(trailing: NavigationLink(destination: ProfileView(isLoggedIn: .constant(true))) {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
            })
            .background(themeManager.currentTheme.backgroundColor) // Добавляем серый фон ко всей навигации
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(ThemeManager()) // Передаем глобальную тему в предосмотр
            .environmentObject(PodcastFetcher()) // Обеспечиваем доступ к данным для превью
    }
}
