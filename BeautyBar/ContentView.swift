//
//  ContentView.swift
//  BeautyBar
//
//  Created by Илья on 15.08.2021.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var tabBar: TabBar
    @EnvironmentObject var userInfo: UserInfo
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                switch tabBar.currentPage {
                case .news:
                    NewsView()
                case .services:
                    ServicesView()
                case .promotions:
                    Text("Promotions")
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
                Spacer()
                TabBarView(tabBar: tabBar, width: geometry.size.width, height: geometry.size.height)
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .onAppear(perform: userInfo.configureFirebaseStateDidChange)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(tabBar: TabBar())
    }
}
