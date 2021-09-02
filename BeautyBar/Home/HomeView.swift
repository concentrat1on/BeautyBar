//
//  HomeView.swift
//  BeautyBar
//
//  Created by Илья on 27.08.2021.
//

import SwiftUI
import Firebase

//MARK: News from Firebase (WIP)
struct HomeView: View {
    @State private var news: [FBNews] = []
    

    var body: some View {
        
        NavigationView {
            List(news) { pieceOfNews in
                VStack(alignment: .leading) {
                    Text("\(pieceOfNews.id)")
                    Text(pieceOfNews.imageURL)
                    Text(pieceOfNews.title)

                }
            }
            .navigationTitle("Новости")
            .onAppear() {
                FBFirestore.retrieveFBNews { result in
                    switch result {
                    case .failure(let error):
                        print(error.localizedDescription)
                    case .success(let data):
                        self.news = data
                            .sorted(by: {$0.id > $1.id })
                    }
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
