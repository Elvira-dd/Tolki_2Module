import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0
    
    let tabs = [
        (view: AnyView(MainView()), icon: "house", title: "Главная"),
        (view: AnyView(RecomendView()), icon: "list.bullet", title: "Подкасты"),
        (view: AnyView(FavoriteView()), icon: "person.circle", title: "Профиль"),
        (view: AnyView(ProfileView()), icon: "gear", title: "Настройки")
    ]
    
    var body: some View {
        ZStack(alignment: .top) {
            tabs[selectedTab].view
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(.background))
                .ignoresSafeArea()
                .padding(.bottom, 30)
            
            CustomTabBar(selectedTab: $selectedTab)
                .frame(maxWidth: .infinity)
                .background(Color.clear)
                
        }
        .padding(.bottom, 0.0)
        .ignoresSafeArea(.all, edges: .bottom)
    }
}
struct CustomTabBar: View {
    @Binding var selectedTab: Int
    
    let icons = ["HomeIcon", "RecIcon", "LikeIcon", "ProfileIcon"]
    let activeIcons = ["ActiveHomeIcon", "ActiveRecIcon", "ActiveLikeIcon", "ActiveProfileIcon"]
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer() // Заставляет таб-бар прижаться к нижнему краю
            
            ZStack {
                RoundedRectangle(cornerRadius: 30)
                    .fill(Color.black)
                    .frame(height: 100)
                    .shadow(radius: 5)
                
                HStack {
                    ForEach(0..<icons.count, id: \.self) { index in
                        Button(action: {
                                selectedTab = index
                            
                        }) {
                            VStack {
                                // Используем тернарный оператор для выбора активного или неактивного изображения
                                Image(selectedTab == index ? activeIcons[index] : icons[index])
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 25, height: 25)
                                
                                if selectedTab == index {
                                    RoundedRectangle(cornerRadius: 2)
                                        .fill(Color.gray)
                                        .frame(width: 40, height: 4)
                                } else {
                                    Color.clear.frame(height: 4)
                                }
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 0)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
