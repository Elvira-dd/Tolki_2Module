import SwiftUI


struct MainView: View {
    @State private var searchText = ""
    @State private var selection: Int = 0
    let menuItems = ["ВСЕ", "НОВОЕ", "ЧАРТЫ", "ПОДБОРКИ"]
    
    @State private var podcasts: [Podcast] = [] // Это твои подкасты, полученные с сервера
    
    // Вытаскиваем только подкасты с id 4, 5, 6, 7
    var newweekpodcasts: [Podcast] {
        podcasts.filter { [4, 5, 6, 7].contains($0.id) }
    }
    
    var podborki: [Podcast] {
        podcasts.filter { [10,11, 16, 17].contains($0.id) }
    }
    
    var newissue: Podcast? {
        podcasts.first { $0.id == 30 }  // Получаем подкаст с id 30
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Image("Logo_full_long")
                        .resizable()  // Делаем изображение масштабируемым
                        .scaledToFit()  // Подгоняем изображение по размеру контейнера
                        .frame(width: 160)  // Устанавливаем размеры
                        .padding(.top, 70.0)
                    
                    Text("Что конкретно вы ищите?")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(Color(.mainLight))
                        .multilineTextAlignment(.center)
                        .padding(.top, 20.0)
                        .frame(width: 250)
                    
                    // Поле поиска (заглушка)
                    HStack {
                        Text("Пост")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(Color(.mainLight))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color(.mainLight4))
                            .cornerRadius(6)
                        Text("Подкаст")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(Color(.mainLight))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color(.mainLight4))
                            .cornerRadius(6)
                        Text("Выпуск")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(Color(.mainLight))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color(.mainLight4))
                            .cornerRadius(6)
                        Text("Автор")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(Color(.mainLight))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color(.mainLight4))
                            .cornerRadius(6)
                    }
                    .padding(.bottom, 20)
                    
                    TextField("Поиск...", text: $searchText)
                        .padding(10)
                        .background(Color(.systemGray6))
                        .cornerRadius(50)
                        .padding(.horizontal)
                    
                    VStack {
                        HStack {
                            // Пункты меню
                            ForEach(0..<menuItems.count, id: \.self) { index in
                                Text(menuItems[index])
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(self.selection == index ? Color("MainGreen") : .gray)
                                    .padding()
                                    .onTapGesture {
                                        self.selection = index
                                    }
                            }
                        }
                        .padding(.vertical, 10)
                        .overlay(
                            Rectangle()
                                .frame(height: 2)
                                .foregroundColor(Color("MainLight3")) // Цвет обводки
                                .offset(y: 20) // Расположение обводки
                        )
                        Spacer()
                    }
                    .padding()
                    
                    // Новые подкасты этой недели
                    VStack(alignment: .leading) {
                        Text("Новые подкасты этой недели")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(Color(.mainLight))
                            .multilineTextAlignment(.leading)
                            .padding(.trailing, 100.0)
                            .padding(.bottom, 20)  // Отступ снизу для заголовка
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        LazyVGrid(columns: [
                            GridItem(.flexible(), spacing: 16),
                            GridItem(.flexible(), spacing: 16)
                        ], spacing: 16) {
                            ForEach(newweekpodcasts) { podcast in
                                NavigationLink(destination: PodcastDetailView(podcast: podcast)) {
                                    VStack(alignment: .leading, spacing: 8) {
                                        AsyncImage(url: URL(string: podcast.coverURL)) { image in
                                            image
                                                .resizable()
                                                .scaledToFill()  // Растягивает изображение по ширине
                                                .frame(height: 170)  // Фиксированная высота для изображения
                                                .clipped()  // Обрезает, если изображение выходит за пределы
                                        } placeholder: {
                                            ProgressView()
                                        }
                                        .clipShape(RoundedRectangle(cornerRadius: 10))  // Закругление углов
                                        
                                        Text(podcast.name)
                                            .font(.system(size: 16, weight: .bold))  // Жирный текст
                                            .foregroundColor(Color("MainLight"))  // Цвет текста по умолчанию
                                            .lineLimit(1)  // Ограничивает количество строк в случае длинного текста
                                            .padding(.top, 8)  // Отступ между картинкой и текстом
                                        Text(podcast.description)
                                            .font(.system(size: 12, weight: .regular))  // Жирный текст
                                            .foregroundColor(Color("MainLight"))  // Цвет текста по умолчанию
                                            .lineLimit(3)  // Ограничивает количество строк в случае длинного текста
                                            .padding(.top, -5)  // Отступ между картинкой и текстом
                                        HStack(alignment: .center) {
                                            Image("persons_icon")
                                                .resizable()  // Делаем изображение масштабируемым
                                                .scaledToFit()  // Подгоняем изображение по размеру контейнера
                                                .frame(width: 20, height: 20)  // Устанавливаем размеры
                                            Text("1567 слушателей")
                                                .font(.system(size: 12, weight: .regular))  // Жирный текст
                                                .foregroundColor(Color("MainLight"))  // Цвет текста по умолчанию
                                                .lineLimit(3)  // Ограничивает количество строк в случае длинного текста
                                                .padding(.top, -5)  // Отступ между картинкой и текстом
                                        }
                                    }
                                    .frame(height: 250)
                                }
                            }
                        }
                        .padding([.leading, .trailing], 0)  // Убираем отступы по горизонтали у LazyVGrid
                    }
                    .padding(.horizontal)
                    
                    // Подборки
                    VStack(alignment: .leading) {
                        Text("Подборки")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(Color(.mainLight))
                            .multilineTextAlignment(.leading)
                            .padding(.trailing, 100.0)
                            .padding(.bottom, 20)  // Отступ снизу для заголовка
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        LazyVGrid(columns: [
                            GridItem(.flexible(), spacing: 16),
                            GridItem(.flexible(), spacing: 16)
                        ], spacing: 16) {
                            ForEach(podborki) { podcast in
                                NavigationLink(destination: PodcastDetailView(podcast: podcast)) {
                                    VStack(alignment: .leading, spacing: 8) {
                                        AsyncImage(url: URL(string: podcast.coverURL)) { image in
                                            image
                                                .resizable()
                                                .scaledToFill()  // Растягивает изображение по ширине
                                                .frame(height: 170)  // Фиксированная высота для изображения
                                                .clipped()  // Обрезает, если изображение выходит за пределы
                                        } placeholder: {
                                            ProgressView()
                                        }
                                        .clipShape(RoundedRectangle(cornerRadius: 10))  // Закругление углов
                                        
                                        Text(podcast.name)
                                            .font(.system(size: 16, weight: .bold))  // Жирный текст
                                            .foregroundColor(Color("MainLight"))  // Цвет текста по умолчанию
                                            .lineLimit(1)  // Ограничивает количество строк в случае длинного текста
                                            .padding(.top, 8)  // Отступ между картинкой и текстом
                                        Text(podcast.description)
                                            .font(.system(size: 12, weight: .regular))  // Жирный текст
                                            .foregroundColor(Color("MainLight"))  // Цвет текста по умолчанию
                                            .lineLimit(3)  // Ограничивает количество строк в случае длинного текста
                                            .padding(.top, -5)  // Отступ между картинкой и текстом
                                        HStack(alignment: .center) {
                                            Image("persons_icon")
                                                .resizable()  // Делаем изображение масштабируемым
                                                .scaledToFit()  // Подгоняем изображение по размеру контейнера
                                                .frame(width: 20, height: 20)  // Устанавливаем размеры
                                            Text("1567 слушателей")
                                                .font(.system(size: 12, weight: .regular))  // Жирный текст
                                                .foregroundColor(Color("MainLight"))  // Цвет текста по умолчанию
                                                .lineLimit(3)  // Ограничивает количество строк в случае длинного текста
                                                .padding(.top, -5)  // Отступ между картинкой и текстом
                                        }
                                    }
                                    .frame(height: 250)
                                }
                            }
                        }
                        .padding([.leading, .trailing], 0)  // Убираем отступы по горизонтали у LazyVGrid
                    }
                    .padding(.horizontal)
                    VStack {
                        // Заголовок с названием свежего выпуска подкаста
                        Text("Свежий выпуск подкаста: \(newissue?.name ?? "Подкаст не найден")")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(Color(.mainLight))
                            .multilineTextAlignment(.leading)
                            .padding(.bottom, 20)  // Отступ снизу для заголовка
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        // Если есть первый выпуск, показываем его детали
                        if let firstIssue = newissue?.issue.first {
                            NavigationLink(destination: IssueDetailView(issue: firstIssue)) {
                                VStack(alignment: .leading) {
                                    AsyncImage(url: URL(string: firstIssue.coverURL)) { image in
                                        image
                                            .resizable()
                                            .scaledToFill()  // Растягивает изображение по ширине
                                            .frame(height: 170)  // Фиксированная высота для изображения
                                            .clipped()  // Обрезает, если изображение выходит за пределы
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    .clipShape(RoundedRectangle(cornerRadius: 10))  // Закругление углов
                                    
                                    // Хедер с названием выпуска и датой
                                    HStack(alignment: .center, spacing: 10.0) {
                                        Text(firstIssue.name) // Название выпуска
                                            .font(.system(size: 16, weight: .bold))  // Жирный текст
                                            .foregroundColor(Color("MainLight"))  // Цвет текста
                                            .lineLimit(2)  // Ограничивает количество строк в случае длинного текста
                                            .padding(.top, 8)  // Отступ между картинкой и текстом
                                        
                                        Spacer()
                                        
                                        Text(firstIssue.createdAt) // Дата выпуска
                                            .font(.system(size: 12, weight: .regular))  // Регулярный текст
                                            .foregroundColor(Color("MainLight2"))  // Цвет текста для даты
                                            .lineLimit(1)  // Ограничивает количество строк
                                            .padding(.top, 8)  // Отступ между картинкой и текстом
                                    }
                                }}
                        } else {
                            // Сообщение, если нет доступных выпусков
                            Text("Нет доступных выпусков")
                                .foregroundColor(.gray)
                                .padding(.top, 8)
                        }
                    }
                    .padding()  // Общий отступ для всего VStack
                }
                
            }
            .background(Color(.background))
            .onAppear {
                PodcastService.shared.fetchPodcasts { podcasts in
                    if let podcasts = podcasts {
                        DispatchQueue.main.async {
                            self.podcasts = podcasts }}}}
        }
    }
}

    

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
         
    }
}

