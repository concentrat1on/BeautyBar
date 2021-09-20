//
//  PieceOfNewsView.swift
//  BeautyBar
//
//  Created by Илья on 06.09.2021.
//

import SwiftUI

struct PieceOfNewsView: View {
    let title: String
    let imageURL: URL
    let placeholder: String
    let texts: [String]
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                LoadImage(url: imageURL,
                          width: UIScreen.main.bounds.width,
                          height: UIScreen.main.bounds.width / 2 * 1)
                Text(title)
                    .font(.system(size: 25))
                    .fontWeight(.bold)
                    .padding(20)
                ForEach(texts, id: \.self) { text in
                    Text(text)
                        .padding(.init(top: 10, leading: 10, bottom: 0, trailing: 10))
                    
                }
            }
        }
    }
}

struct PieceOfNewsView_Previews: PreviewProvider {
    static var previews: some View {
        PieceOfNewsView(title: "title", imageURL: URL(string: "https://i.ibb.co/qMjkkDQ/image.jpg")!, placeholder: "Загрузка", texts: ["text1", "text2"])
    }
}
