//
//  BeautyBarApp.swift
//  BeautyBar
//
//  Created by Илья on 15.08.2021.
//

import SwiftUI

@main
struct BeautyBarApp: App {

    var userInfo = UserInfo()
    @StateObject var viewRouter = TabBar()
    @ObservedObject var favorites = FavoritesModel()
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(userInfo)
                .environmentObject(favorites)
                .environmentObject(viewRouter)
        }
    }
}

extension UIApplication {
    
    func addTapGestureRecognizer() {
        guard let window = windows.first else { return }
        let tapGesture = UITapGestureRecognizer(target: window, action: #selector(UIView.endEditing))
        tapGesture.requiresExclusiveTouchType = false
        tapGesture.cancelsTouchesInView = false
        tapGesture.delegate = self
        window.addGestureRecognizer(tapGesture)
    }
}


extension UIApplication: UIGestureRecognizerDelegate {
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
