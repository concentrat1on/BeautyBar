//
//  SingleServiceView.swift
//  BeautyBar
//
//  Created by Илья on 13.09.2021.
//

import SwiftUI
import RealmSwift

struct SingleServiceView: View {
    
    @EnvironmentObject var favorites: FavoritesModel
    @EnvironmentObject var userInfo: UserInfo
    @Environment(\.presentationMode) var presentationMode
    @State private var showingDeleteAlert = false

    let service: FBServices
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text(service.title)
                    .font(.system(size: 25))
                    .fontWeight(.bold)
                HStack {

                    AsyncImage(url: URL(string: service.imageURL)!,
                               placeholder: { Image("Loading")
                            .resizable()
                            .frame(width: 30, height: 30) },
                               image: { Image(uiImage: $0).resizable() })
                        .frame(width: 120, height: 120)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    Text(service.uid)
                        .font(.system(size: 15))
                        .fontWeight(.regular)
                        .foregroundColor(.gray)
                    Spacer()
                   
                    Button(action: buttonAction) {
                        buttonLabel()
                            .foregroundColor(.red)
                    }

                }
                .padding(.init(top: 10, leading: 0, bottom: 10, trailing: 0))
                Divider()
                Text(service.text)
                Spacer()
            }
            .padding()
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            if userInfo.isUserAuntheticated == .signedIn && userInfo.user.uid == service.uid {
                Button("Удалить услугу") {
                    self.showingDeleteAlert.toggle()
                }
            }
            
        }
        .onAppear() {
            favorites.fetchData()
            print(Realm.Configuration.defaultConfiguration.fileURL!)
            
        }
        .alert(isPresented: $showingDeleteAlert) {
            Alert(title: Text("Удаление услуги"),
                  message: Text("Вы точно хотите удалить данную услугу?"),
                  primaryButton: .destructive(Text("Да")) {
                FBFirestore.deleteService(reference: "services", id: service.id)
                presentationMode.wrappedValue.dismiss()
            },
                  secondaryButton: .cancel(Text("Нет"))
            )}
    }
}


struct SingleServiceView_Previews: PreviewProvider {
    static var previews: some View {
        SingleServiceView(service: FBServices.init(id: 0, date: Date(), uid: "uid", imageURL: "imageURL", title: "title", price: 0, service: "service", city: "city", phoneNumber: "phoneNumber", email: "email", text: "text"))
    }
}

extension SingleServiceView {
    
    func buttonAction() {
        if favorites.contains(service.id) {
            favorites.deleteData(service)
            print("deleted")
        } else {
            favorites.addData(service)
            print("added")
        }
    }
    
    func buttonLabel() -> Image {
        favorites.contains(service.id) ?
            Image(systemName: "heart.fill") :
            Image(systemName: "heart")
    }
}
