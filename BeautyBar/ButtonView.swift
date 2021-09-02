//
//  ProfileLogInView.swift
//  BBSwiftUI
//
//  Created by Илья on 13.08.2021.
//

import SwiftUI

struct ButtonView: View {
    
    let width: CGFloat
    let height: CGFloat
    let text: String
    let color: Color
    let frameColor: Color
    let opacity: Double
    let action: () -> Void

    var body: some View {
        VStack{
            Button(action: action) {
                Text(text)
                    .font(.system(size: 20))
                    .fontWeight(.light)
                    .foregroundColor(color)
            }
            .frame(width: width, height: height)
            .background(frameColor)
            .cornerRadius(10)
            .overlay(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .stroke(color, lineWidth: 1)
            )
            .opacity(opacity)
        }
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(width: 175, height: 50, text: "Log In", color: .black, frameColor: .white, opacity: 0.5, action: {})
    }
}
