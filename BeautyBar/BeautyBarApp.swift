//
//  BeautyBarApp.swift
//  BeautyBar
//
//  Created by Илья on 15.08.2021.
//

import SwiftUI

@main
struct BeautyBarApp: App {
    
    @StateObject var viewRouter = TabBar()
    var userInfo = UserInfo()
    @ObservedObject var favorites = FavoritesModel()
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView(tabBar: viewRouter)
                .environmentObject(userInfo)
                .environmentObject(favorites)
        }
    }
}
