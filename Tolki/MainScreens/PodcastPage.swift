import SwiftUI


struct PodcastView: View {
        @State private var podcasts: [Podcast] = []
        
        var body: some View {
            NavigationView {
                List(podcasts) { podcast in
                    NavigationLink(destination: PodcastDetailView(podcast: podcast)) {
                        HStack {
                            AsyncImage(url: URL(string: podcast.coverURL)) { image in
                                image.resizable().scaledToFit().frame(width: 50, height: 50)
                            } placeholder: {
                                ProgressView()
                            }
                            Text(podcast.name)
                                .font(.headline)
                        }
                    }
                }
                .navigationTitle("Подкасты")
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
    PodcastView()
}

