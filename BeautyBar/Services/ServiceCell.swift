//
//  ServiceCell.swift
//  BeautyBar
//
//  Created by Илья on 27.08.2021.
//

import SwiftUI

struct ServiceCell: View {
    // MARK: Cell for ServiceView
    
    let text: String
    let image: Image
    
    private let color = Color.init(
        red: Double.random(in: 0.1...0.9),
        green: Double.random(in: 0.1...0.9),
        blue: Double.random(in: 0.1...0.9)
    )
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Text(text)
                    .font(.system(size: 25))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 3)
                    .padding(.leading)
                HStack {
                    Spacer()
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 90, height: 90)
                        .padding([.bottom, .trailing], 6)
                }
                .frame(width: 175)
            }
        }
        .background(color)
        .cornerRadius(20)
        .shadow(color: color, radius: 5, x: 0.0, y: 0.0)
    }
}

struct ServiceCell_Previews: PreviewProvider {
    static var previews: some View {
        ServiceCell(text: "Макияж", image: Image("MakeUp"))
    }
}
