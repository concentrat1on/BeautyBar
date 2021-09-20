import SwiftUI

struct TabBarView: View {
    
    @StateObject var tabBar: TabBar
    
    var width: CGFloat
    var height: CGFloat
    
    var body: some View {
        HStack {

            TabBarIconView(
                tabBar: tabBar,
                assignedPage: .services,
                width: width/5,
                height: height/35,
                systemIconName: "magnifyingglass",
                tabName: "Услуги"
            )
            TabBarIconView(
                tabBar: tabBar,
                assignedPage: .favorites,
                width: width/5,
                height: height/35,
                systemIconName: "heart",
                tabName: "Избранное"
            )
            TabBarIconView(
                tabBar: tabBar,
                assignedPage: .promotions,
                width: width/5,
                height: height/35,
                systemIconName: "gift",
                tabName: "Акции"
            )
            TabBarIconView(
                tabBar: tabBar,
                assignedPage: .news,
                width: width/5,
                height: height/35,
                systemIconName: "house",
                tabName: "Новости"
            )
            TabBarIconView(
                tabBar: tabBar,
                assignedPage: .profile,
                width: width/5,
                height: height/35,
                systemIconName: "person.crop.circle",
                tabName: "Профиль"
            )
        }
        .frame(width: width, height: height/10.5)
        .background(Color("TabBarBackground"))
        .shadow(radius: 2)
    }
    
}
