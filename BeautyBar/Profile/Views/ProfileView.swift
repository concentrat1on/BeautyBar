//
//  ProfileView.swift
//  BeautyBar
//
//  Created by Илья on 15.08.2021.
//

import SwiftUI
import Firebase

struct ProfileView: View {
    @State var color: Color = Color.blue
    @EnvironmentObject var userInfo: UserInfo
    var body: some View {
        NavigationView {
            Text("Hello World")
                .navigationTitle("Привет, \(userInfo.user.name)!")
                .navigationBarItems(trailing: Button("Выйти") {
                    FBAuth.logout { result in
                        switch result {
                        case .failure(let error):
                            print(error.localizedDescription)
                        case.success( _):
                            print("Вы успешно вышли из аккаунта")
                        }
                    }
                })
                .onAppear {
/*                    guard let uid = Auth.auth().currentUser?.uid else {
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
 */
                }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
