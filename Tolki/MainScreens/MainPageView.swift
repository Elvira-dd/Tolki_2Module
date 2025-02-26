import SwiftUI


struct TopView: View {
    @StateObject var dataFetcher = PodcastFetcher()

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                
                // Экран с текстом и кнопкой
                ZStack(alignment: .center) {
                    Image("mainPageCover")
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width, height: 450) // Растягиваем картинку
                        .clipped()
                        .ignoresSafeArea()

                    VStack {
                        Text("Ищи и оставляй отзывы о своих любимых подкастах")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(Color(.mainGreen))
                            .multilineTextAlignment(.center)
                            .padding(.top, 26)
                            .frame(width: 250)

                        NavigationLink(destination: CreatePostView()) {
                            HStack(spacing: 10) {
                                Text("Оставить рецензию")
                                    .foregroundColor(Color(.mainLight5))
                                    .padding()
                                Image("Arrow_top_right")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                            }
                            .padding()
                            .frame(width: 300)
                            .background(Color(.mainGreen))
                            .cornerRadius(10)
                            .padding(.top, 20)
                        }
                    }
                    .frame(height: 450)
                }
                .frame(width: UIScreen.main.bounds.width, height: 450) // Ограничиваем высоту блока

                // Топ подкастов
                VStack(alignment: .leading, spacing: 10) {
                    Text("Сегодня в топе эти подкасты")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(Color(.mainLight))
                        .padding(.leading)

                    ForEach(dataFetcher.podcasts.prefix(4), id: \.id) { podcast in
                        NavigationLink(destination: PodcastDetailView(podcast: podcast)) {
                            VStack(alignment: .leading) {
                                AsyncImage(url: URL(string: podcast.cover)) { phase in
                                    switch phase {
                                    case .empty:
                                        ProgressView()
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .scaledToFill()
                                            .clipped()
                                    case .failure:
                                        Image(systemName: "photo")
                                            .resizable()
                                            .scaledToFit()
                                            .foregroundColor(.gray)
                                    @unknown default:
                                        EmptyView()
                                    }
                                }
                                .frame(height: 150)

                                VStack(alignment: .leading, spacing: 10) {
                                    Text(podcast.name)
                                        .font(.title2)
                                        .multilineTextAlignment(.leading)
                                        .bold()
                                        .foregroundColor(Color(.mainLight))

                                    Text(podcast.description)
                                        .font(.body)
                                        .multilineTextAlignment(.leading)
                                        .foregroundColor(Color(.mainLight2))
                                }
                            }
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(10)
                            .shadow(radius: 5)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                }
                .padding(.top)

                // Свежие выпуски
                VStack(alignment: .leading, spacing: 10) {
                    Text("Свежие выпуски подкастов")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(Color(.mainLight))
                        .padding(.leading)

                    ForEach(dataFetcher.issues.prefix(6), id: \.id) { issue in
                        VStack(alignment: .leading) {
                            Text(issue.name)
                                .font(.title2)
                                .bold()
                                .foregroundColor(.black)
                            Text("Ссылка: \(issue.link)")
                                .font(.body)
                                .foregroundColor(.gray)
                        }
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .padding(.top)

                Spacer()
            }
            .padding()
            .background(Color(.background))
            .onAppear {
                dataFetcher.fetchData()
            }
        }
        .background(Color(.background)) // Устанавливаем фон для всего ScrollView
    }
}
struct TopView_Previews: PreviewProvider {
    static var previews: some View {
        TopView()
            .environmentObject(PodcastFetcher())
    }
}
