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
            ScrollView {
            AsyncImage(url: URL(string: userInfo.user.profilePhotoURL)!,
                       placeholder: { Image("Loading")
                    .resizable()
                    .frame(width: 50, height: 50) },
                       image: { Image(uiImage: $0).resizable() })
                .frame(width: UIScreen.main.bounds.width - 41, height: UIScreen.main.bounds.width / 2 * 1 - 20.5)
            Divider()
            NavigationLink(destination: SectionServiceView(key: userInfo.user.uid, object: "uid", title: "Ваши Услуги")) {
                VStack(alignment: .leading) {
                    HStack {
                        Text("Ваши услуги")
                            .padding()
                    }
                    Divider()
                }
            }
            }
                
            .navigationTitle("Привет, \(userInfo.user.firstName)!")
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
        }
        
        
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

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
