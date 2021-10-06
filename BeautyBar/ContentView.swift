//
//  ContentView.swift
//  BeautyBar
//
//  Created by Илья on 15.08.2021.
//

import SwiftUI
import Firebase

struct ContentView: View {
    
    @EnvironmentObject var tabBar: TabBar
    @EnvironmentObject var userInfo: UserInfo

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                Spacer()
                switch tabBar.currentPage {
                case .news:
                    NewsView()
                case .services:
                    ServicesView()
                case .promotions:
                    AddServiceView()
                case .favorites:
                    Text("Favorites")
                case .profile:
                    if userInfo.isUserAuntheticated == .undefined {
                        Text("Загрузка, подождите пожалуйста")
                    } else if userInfo.isUserAuntheticated == .signedOut {
                        LoginView()
                    } else {
                        ProfileView()
                    }
                }
                TabBarView(tabBar: tabBar, width: geometry.size.width, height: geometry.size.height)
            }
        }
//        TabView {
//            ServicesView()
//                .tabItem {
//                    Label("Сервисы", systemImage: "paintbrush")
//                }
//            Text("Promotions")
//                .tabItem {
//                    Label("Акции", systemImage: "flame")
//                }
//            Text("Favorites")
//                .tabItem {
//                    Label("Избранное", systemImage: "heart")
//                }
//            NewsView()
//                .tabItem {
//                    Label("Новости", systemImage: "icloud")
//                }
//            if userInfo.isUserAuntheticated == .undefined {
//                Text("Загрузка, подождите пожалуйста")
//                    .tabItem {
//                        Label("Профиль", systemImage: "person")
//                    }
//            } else if userInfo.isUserAuntheticated == .signedOut {
//                LoginView()
//                    .tabItem {
//                        Label("Профиль", systemImage: "person")
//                    }
//            } else {
//                ProfileView()
//                    .tabItem {
//                        Label("Профиль", systemImage: "person")
//                    }
//            }
//        }
        .edgesIgnoringSafeArea(.bottom)
        .onAppear(perform: userInfo.configureFirebaseStateDidChange)
        .onAppear {
            guard let uid = Auth.auth().currentUser?.uid else {
                return
            }
            FBFirestore.retrieveFBUser(uid: uid) { result in
                switch result {
                case .failure(let error):
                    print(error.localizedDescription)
                case.success(let user):
                    self.userInfo.user = user
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
