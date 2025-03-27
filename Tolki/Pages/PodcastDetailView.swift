//
//  PodcastDetailView.swift
//  Cry
//
//  Created by Эльвира on 27.03.2025.
//

import SwiftUI


struct PodcastDetailView: View {
    @State private var selection: Int = 0
    let menuItems = ["ВСЕ", "ВЫПУСКИ", "ОТЗЫВЫ", "ПОСТЫ"]
    var podcast: Podcast
    @State private var podcasts: [Podcast] = []
    
    var samepodcasts: [Podcast] {
        podcasts.filter { [4, 5, 6, 7].contains($0.id) }
    }
    
    var body: some View {
        NavigationView{
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    AsyncImage(url: URL(string: podcast.coverURL)) { image in
                        image
                            .resizable()
                            .scaledToFill()  // Растягивает изображение по ширине
                            .frame(width: .infinity, height: 350.0)  // Фиксированная высота для изображения
                            .clipped()  // Обрезает, если изображение выходит за пределы
                            .cornerRadius(12)
                        
                        
                    } placeholder: {
                        ProgressView()
                    }
                    
                    HStack {
                        ForEach(podcast.themes, id: \.id) { theme in
                            Text(theme.name)
                                .font(.system(size: 12, weight: .medium))
                                .foregroundColor(Color("MainLight"))
                                .lineLimit(1)
                                .padding(.vertical, 8)
                                .padding(.horizontal, 16)
                                .background(Color("MainLight3"))
                                .cornerRadius(8)
                        }
                    }
                    
                    Text(podcast.name)
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(Color(.mainLight))
                        .multilineTextAlignment(.leading)
                    
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    
                    Text(podcast.description)
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(Color(.mainLight))
                        .multilineTextAlignment(.leading)
                        .padding(.bottom, 12)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    
                    // Отображение авторов
                    VStack(alignment: .leading) {
                        Text("Авторы:")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(Color(.mainLight))
                            .multilineTextAlignment(.leading)
                        
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        ForEach(podcast.authors) { author in
                            HStack(alignment: .center) {
                                
                                AsyncImage(url: URL(string: author.avatarURL)) { image in
                                    image.resizable()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                                VStack(){
                                    Text(author.name)
                                        .font(.system(size: 16, weight: .bold))
                                        .foregroundColor(Color(.mainLight))
                                        .multilineTextAlignment(.leading)
                                    
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    Text("ведущая" )
                                        .font(.system(size: 14, weight: .regular))
                                        .foregroundColor(Color(.mainLight2))
                                        .multilineTextAlignment(.leading)
                                    
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }
                            }
                        }
                        
                    }
                    
                    .padding(.top)
                    
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
                        
                    }
                    
                    
                    Text("Выпуски:")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(Color(.mainLight))
                        .multilineTextAlignment(.leading)
                        .padding(.top, 20)  // Отступ снизу для заголовка
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) { // Промежуток между элементами
                            ForEach(podcast.issue) { issue in
                                NavigationLink(destination: IssueDetailView(issue: issue)) {
                                    VStack(alignment: .leading) {
                                        AsyncImage(url: URL(string: issue.coverURL)) { image in
                                            image
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 300.0, height: 200.0)
                                                .clipped()
                                        } placeholder: {
                                            ProgressView()
                                        }
                                        .frame(width: .infinity, height: 150) // Размер изображения
                                        .clipShape(RoundedRectangle(cornerRadius: 10)) // Скругление
                                        
                                        VStack( alignment: .leading, spacing: 6.0) {
                                            Text(issue.name) // Название выпуска
                                                .font(.system(size: 16, weight: .bold))  // Жирный текст
                                                .foregroundColor(Color("MainLight"))  // Цвет текста
                                                .multilineTextAlignment(.leading)
                                                .lineLimit(2)  // Ограничивает количество строк в случае длинного текста
                                                .padding(.top, 8)  // Отступ между картинкой и текстом
                                            
                                            
                                            
                                            Text(issue.createdAt) // Дата выпуска
                                                .font(.system(size: 12, weight: .regular))  // Регулярный текст
                                                .foregroundColor(Color("MainLight2"))  // Цвет текста для даты
                                                .lineLimit(1)  // Ограничивает количество строк
                                                .padding(.top, 8)  // Отступ между картинкой и текстом
                                        }
                                    }
                                    .frame(width: 300) // Фиксированная ширина карточки
                                    .padding(.vertical, 8)
                                }
                            }
                        }
                        
                    }
                    VStack(){
                        Text("Рейтинг подкастов")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(Color("MainLight"))
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        HStack(){
                            HStack(){
                                Image("StarIconFill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height:30)
                                Image("StarIconFill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height:30)
                                Image("StarIconFill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height:30)
                                Image("StarIconFill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height:30)
                                Image("StarIconNoFill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height:30)
                            }
                            Spacer()
                            Text("4.6")
                                .font(.system(size: 32, weight: .bold))
                                .foregroundColor(Color("MainGreen"))
                                .multilineTextAlignment(.leading)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text("Оценили 20459 пользователей")
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(Color("MainLight"))
                                .multilineTextAlignment(.leading)
                                .frame(width: 100, alignment: .leading)
                        }
                        HStack() {
                            VStack(alignment: .leading){
                                Text("76%")
                                    .font(.system(size: 64, weight: .medium))
                                    .foregroundColor(Color("MainLight"))
                                    .multilineTextAlignment(.leading)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Text("Интересная тема обсуждений")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(Color("MainLight"))
                                    .multilineTextAlignment(.leading)
                                    .frame(width: 160, alignment: .leading)
                            }
                            .frame(width:150)
                            .padding(.all,16)
                            .background(Color("MainLight4"))
                            .cornerRadius(8)
                            
                            VStack(alignment: .leading){
                                Text("46%")
                                    .font(.system(size: 64, weight: .medium))
                                    .foregroundColor(Color("MainLight"))
                                    .multilineTextAlignment(.leading)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Text("Глубокий анализ материала")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(Color("MainLight"))
                                    .multilineTextAlignment(.leading)
                                    .frame(width: 140, alignment: .leading)
                            }
                            .frame(width:150)
                            .padding(.all,16)
                            .background(Color("MainLight4"))
                            .cornerRadius(8)
                        }
                        
                    }
                    .padding(.top, 50)
                    
                    Text("Похожее")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(Color(.mainLight))
                        .multilineTextAlignment(.leading)
                        .padding(.top, 20)  // Отступ снизу для заголовка
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) { // Промежуток между элементами
                            ForEach(samepodcasts) { podcast in
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
                                    .frame(width: 180.0, height: 250)
                                }
                            }
                        }
                        
                    }
                    Image("subscribe_ad")
                        .resizable()
                        .scaledToFit()
                        .frame(width: .infinity)
                        .cornerRadius(12)
                        .padding(.top, 30.0)
                    
                    Text("Лента автора")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(Color(.mainLight))
                        .multilineTextAlignment(.leading)
                        .padding(.top, 20)  // Отступ снизу для заголовка
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    ForEach(podcast.posts) { post in
                        NavigationLink(destination: PodcastDetailView(podcast: podcast)) {
                            HStack(alignment: .center, spacing: 12) {
                                AsyncImage(url: URL(string: podcast.coverURL)) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 45, height: 45)
                                        .clipped()
                                        .cornerRadius(100)
                                } placeholder: {
                                    ProgressView()
                                }
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                
                                Text(podcast.name)
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(Color("MainLight"))
                                    .lineLimit(2)
                                    .padding(.top, 8)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .frame(alignment: .leading)
                        
                        
                        VStack(alignment: .leading) {
                            Text(post.title)
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(Color("MainLight"))
                                .multilineTextAlignment(.leading)
                            
                            
                            
                            Text(post.createdAt)
                                .font(.system(size: 14, weight: .regular))
                                .foregroundColor(Color("MainLight"))
                                .multilineTextAlignment(.leading)
                                .padding(.top, 8)
                            
                            HStack(spacing: 12) {
                                Image("IconLike")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                                
                                Image("IconDislike")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                                Image("IconShare")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                                Spacer()
                                NavigationLink(destination: PostDetailView(post: post)) {
                                    Text("Перейти в обсуждение")
                                        .font(.system(size: 16, weight: .bold))
                                        .foregroundColor(Color("Background"))
                                        .multilineTextAlignment(.center)
                                        .padding(.horizontal, 16)
                                        .padding(.vertical,8)
                                        .background(Color("MainGreen"))
                                        .cornerRadius(8)
                                }
                            }
                            .padding(.top, 16)
                        }
                        
                        
                        
                        
                        if let firstComment = post.comments.first {
                            VStack(alignment: .leading) {
                                HStack(alignment: .center) {
                                    Image("ProfileAvatar")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 32, height: 32)
                                        .cornerRadius(50)
                                    
                                    VStack(alignment: .leading) {
                                        Text(firstComment.userName)
                                            .font(.system(size: 14, weight: .medium))
                                            .foregroundColor(Color("MainLight"))
                                        
                                        Text("Знаток подкастов 8 уровня")
                                            .font(.system(size: 12, weight: .regular))
                                            .foregroundColor(Color("MainLight"))
                                    }
                                    
                                    Spacer()
                                    
                                    Text(firstComment.createdAt)
                                        .font(.system(size: 12, weight: .regular))
                                        .foregroundColor(Color("MainLight"))
                                }
                                
                                Text(firstComment.content)
                                    .font(.system(size: 14, weight: .regular))
                                    .foregroundColor(Color("MainLight"))
                                    .multilineTextAlignment(.leading)
                                    .padding(.top, 8)
                                
                                HStack(spacing: 12) {
                                    Image("IconLike")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 24, height: 24)
                                    
                                    Image("IconDislike")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 24, height: 24)
                                }
                                .padding(.top, 16)
                            }
                            .padding(16)
                            .background(Color("MainLight4"))
                            .cornerRadius(8)
                            .padding(.top, 24)
                        } else {
                            Text("Нет доступных выпусков")
                                .foregroundColor(.gray)
                                .padding(.top, 8)
                        }
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                    }
                    
                }
                .padding()
            }
            
            .background(Color(.background))
            .onAppear {
                PodcastService.shared.fetchPodcasts { podcasts in
                    if let podcasts = podcasts {
                        DispatchQueue.main.async {
                            self.podcasts = podcasts
                        }
                    }
                }
            }
        }
        }
}

#Preview {
    PodcastDetailPreview()
}

struct PodcastDetailPreview: View {
    @State private var podcast: Podcast? = nil

    var body: some View {
        Group {
            if let podcast = podcast {
                PodcastDetailView(podcast: podcast)
            } else {
                ProgressView("Загружаем подкаст...")
            }
        }
        .task {
            await loadPodcast()
        }
    }

    func loadPodcast() async {
        guard let url = URL(string: "http://localhost:3000/api/v1/podcasts/1") else { return }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedPodcast = try JSONDecoder().decode(Podcast.self, from: data)

            DispatchQueue.main.async {
                self.podcast = decodedPodcast
            }
        } catch {
            print("Ошибка загрузки подкаста: \(error)")
        }
    }
}
