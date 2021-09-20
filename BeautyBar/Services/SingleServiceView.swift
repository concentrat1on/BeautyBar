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

    let service: FBServices
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text(service.title)
                    .font(.system(size: 25))
                    .fontWeight(.bold)
                HStack {
                    Text("+380502222222")
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
        .onAppear() {
            favorites.fetchData()
            print(Realm.Configuration.defaultConfiguration.fileURL!)
        }
    }
}


struct SingleServiceView_Previews: PreviewProvider {
    static var previews: some View {
        SingleServiceView(service: FBServices.init(id: 0, service: "service", title: "title", text: "text", date: Date()))
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
