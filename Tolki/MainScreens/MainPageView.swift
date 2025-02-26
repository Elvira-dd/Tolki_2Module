import SwiftUI

struct TopView: View {
    @StateObject var dataFetcher = PodcastFetcher() // Инициализируем PodcastFetcher
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Первый экран с фоном на всю ширину
                VStack {
                    Text("Ищи и оставляй отзывы о своих любимых подкастах")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(Color.green) // Стандартный цвет
                        .multilineTextAlignment(.center)
                        .padding(.top, 26.0)
                        .frame(width: 250)

                    NavigationLink(destination: CreatePostView()) {
                        HStack(spacing: 10) {
                            Text("Оставить рецензию")
                                .foregroundColor(Color.white) // Стандартный цвет
                                .padding()
                            Image("Arrow_top_right")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .foregroundColor(Color.white) // Стандартный цвет
                        }
                        .padding()
                        .frame(width: 300)
                        .background(Color.green) // Стандартный цвет
                        .cornerRadius(10)
                        .padding(.top, 20)
                    }
                }
                .frame(maxWidth: .infinity) // Растягиваем в ширину
                .frame(height: 450) // Отдельный вызов для высоты
                .background(
                    Image("mainPageCover")
                        .resizable()
                        .scaledToFill()
                        .clipped()
                )
                .edgesIgnoringSafeArea([.leading, .trailing]) // Игнорируем safe area только по бокам
                
                // Топ подкастов
                VStack(alignment: .leading) {
                    Text("Сегодня в топе эти подкасты")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(Color.black) // Стандартный цвет
                        .padding(.leading)
                    
                    ForEach(dataFetcher.podcasts.prefix(4), id: \.id) { podcast in
                        NavigationLink(destination: PodcastDetailView(podcast: podcast)) {
                            VStack(alignment: .leading) {
                                AsyncImage(url: URL(string: podcast.cover)) { phase in
                                    switch phase {
                                    case .empty:
                                        ProgressView() // Индикатор загрузки
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .scaledToFill()
                                            .clipped()
                                    case .failure:
                                        Image(systemName: "photo") // Заглушка при ошибке
                                            .resizable()
                                            .scaledToFit()
                                            .foregroundColor(.gray)
                                    @unknown default:
                                        EmptyView()
                                    }
                                }
                                .frame(height: 150) // Задай размер, чтобы картинка отображалась
                                
                                Text(podcast.name)
                                    .font(.title2)
                                    .bold()
                                    .foregroundColor(Color.black) // Стандартный цвет
                                Text(podcast.description)
                                    .font(.body)
                                    .foregroundColor(Color.gray) // Стандартный цвет
                            }
                            .padding()
                            .background(Color.gray.opacity(0.1)) // Фон карточки
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
                        .foregroundColor(Color.black) // Стандартный цвет
                        .padding(.leading)
                    
                    ForEach(dataFetcher.issues.prefix(6), id: \.id) { issue in
                        VStack(alignment: .leading) {
                            Text(issue.name)
                                .font(.title2)
                                .bold()
                                .foregroundColor(Color.black) // Стандартный цвет
                            Text("Ссылка: \(issue.link)")
                                .font(.body)
                                .foregroundColor(Color.gray) // Стандартный цвет
                        }
                        .padding()
                        .background(Color.gray.opacity(0.1)) // Фон карточки
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .frame(maxWidth: .infinity, alignment: .leading) // Выровнять по левому краю
                    }
                }
                .padding(.top)
            }
            .padding()
            .background(Color.white) // Фон для всей страницы
            .cornerRadius(10)
            .onAppear {
                dataFetcher.fetchData() // Загружаем данные при запуске
            }
        }
        .background(Color.white) // Добавляем белый фон ко всей навигации
    }
}

struct TopView_Previews: PreviewProvider {
    static var previews: some View {
        TopView()
            .environmentObject(PodcastFetcher()) // Обеспечиваем доступ к данным для превью
    }
}
