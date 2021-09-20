//
//  HomeView.swift
//  BeautyBar
//
//  Created by Илья on 27.08.2021.
//

import SwiftUI
import Firebase

//MARK: News from Firebase (WIP)
struct NewsView: View {
    
    
    @State private var news: [FBNews] = []
    let columns = [GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            ScrollView {
                 VStack {
                    ForEach(news) { pieceOfNews in
                        NewsCell(
                            title: pieceOfNews.title,
                            imageURL: URL(string: pieceOfNews.imageURL)!, placeholder: "", texts: pieceOfNews.text)
                            .padding(.bottom, 15)
                    }
                }
                 .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
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
        NewsView()
    }
}
