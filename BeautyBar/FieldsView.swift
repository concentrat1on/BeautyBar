//
//  TextFieldView.swift
//  BBSwiftUI
//
//  Created by Илья on 13.08.2021.
//

import SwiftUI

struct TextFieldView: View {
    
    @Binding var text: String
    var color = Color(.black)
    var placeholder = ""
    
    var body: some View {
        TextField(placeholder, text: $text)
            .disableAutocorrection(true)
            .autocapitalization(.none)
            .padding(10)
            .font(Font.system(size: 17, weight: .medium, design: .monospaced))
            .overlay(
                RoundedRectangle(
                    cornerRadius: 10)
                    .stroke(color,
                            lineWidth: 1)
            )
    }
}

struct TextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldView(text: .constant("Hello"))
    }
}

struct SecureFieldView: View {
    
    @Binding var text: String
    var color = Color(.black)
    var placeholder = ""
    
    var body: some View {
        SecureField(placeholder, text: $text)
            .disableAutocorrection(true)
            .autocapitalization(.none)
            .padding(10)
            .font(Font.system(size: 17, weight: .medium, design: .monospaced))
            .overlay(
                RoundedRectangle(
                    cornerRadius: 10)
                    .stroke(color,
                            lineWidth: 1)
            )
    }
}

struct SecureFieldView_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldView(text: .constant("Hello"))
    }
}
