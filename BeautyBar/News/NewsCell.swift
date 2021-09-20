//
//  NewsCell.swift
//  BeautyBar
//
//  Created by Илья on 05.09.2021.
//

import SwiftUI

struct NewsCell: View {
    let title: String
    let color = Color.init(
        red: Double.random(in: 0.1...0.9),
        green: Double.random(in: 0.1...0.9),
        blue: Double.random(in: 0.1...0.9)
    )
    let imageURL: URL
    let placeholder: String
    let image = Image("xmark.shield")
    let texts: [String]
    var body: some View {
        NavigationLink(destination: PieceOfNewsView(
            title: title, 
            imageURL: imageURL,
            placeholder: placeholder,
            texts: texts
        )) {
            ZStack {
                VStack(alignment: .center) {
                    LoadImage(url: imageURL,
                              width: UIScreen.main.bounds.width - 41,
                              height: UIScreen.main.bounds.width / 2 * 1 - 20.5)
                    Text(title)
                        .font(.system(size: 25))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                }
                .frame(width: UIScreen.main.bounds.width - 41, alignment: .center)
                .background(color)
                .cornerRadius(40)
                .shadow(color: color, radius: 8, x: 0.0, y: 0.0)
            }
        }
    }
}

struct NewsCell_Previews: PreviewProvider {
    static var previews: some View {
        NewsCell(title: "Привет как дела", imageURL: URL(string: "https://i.ibb.co/qMjkkDQ/image.jpg")!, placeholder: "Загрузка", texts: ["text1", "text2"])
    }
}
