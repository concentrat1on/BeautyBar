//
//  SignUpView.swift
//  BeautyBar
//
//  Created by Илья on 15.08.2021.
//

import SwiftUI

struct SignUpView: View {
    
    @EnvironmentObject var userInfo: UserInfo
    @State var user: UserViewModel = UserViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State private var showError = false
    @State private var errorString = ""
    
    var color: Color {
        user.isSignUpIsComplete ? .green : .red
    }

    var body: some View {
        NavigationView {
            VStack {
                Group {
                    VStack(alignment: .leading) {
                        TextFieldView(text: self.$user.email, color: .black, placeholder: "Email адрес")
                        if !user.validEmailText.isEmpty {
                            Text(user.validEmailText).font(.caption).foregroundColor(.red)
                        }
                    }
                    VStack(alignment: .leading) {
                        SecureFieldView(text: self.$user.password, color: .black, placeholder: "Пароль")
                        if !user.validPasswordText.isEmpty {
                            Text(user.validPasswordText).font(.caption).foregroundColor(.red)
                        }
                    }
                    VStack(alignment: .leading) {
                        SecureFieldView(text: self.$user.confirmPassword, color: .black, placeholder: "Повторите пароль")
                        if !user.passwordMatch(ConfirmPassword: user.confirmPassword) {
                            Text(user.validConfirmPasswordText).font(.caption).foregroundColor(.red)
                        }
                    }
                    .padding(.bottom, 30)
                    VStack(alignment: .leading) {
                        TextFieldView(text: self.$user.fullname, color: .gray, placeholder: "Имя и Фамилия")
                        if !user.validFullnameText.isEmpty {
                            Text(user.validFullnameText).font(.caption).foregroundColor(.red)
                        }

                    }
                    VStack(alignment: .leading) {
                        TextFieldView(text: self.$user.city, color: .gray, placeholder: "Город")
                        if !user.validCityText.isEmpty {
                            Text(user.validCityText).font(.caption).foregroundColor(.red)
                        }
                    }
                } .frame(width: 350)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                
                VStack(spacing: 20) {
                    ButtonView(
                        width: 225,
                        height: 50,
                        text: "Зарегистрироваться",
                        color: .white,
                        frameColor: color,
                        opacity: 1) {
                        FBAuth.createUser(
                            withEmail: self.user.email,
                            name: self.user.fullname,
                            password: self.user.password,
                            city: self.user.city) { result in
                            switch result {
                            case .failure(let error):
                                self.errorString = error.localizedDescription
                                self.showError = true
                            case .success( _):
                                print("Аккаунт успешно был зарегистрирован")
                            }
                        }
                    }
                    .disabled(!user.isSignUpIsComplete)
                    Spacer()
                } .padding(50)
            } .padding(.top)
            .alert(isPresented: $showError) {
                Alert(
                    title: Text("Ошибка во время создания аккаунта"),
                    message: Text(errorString),
                    dismissButton: .default(Text("OK")))
            }
            .navigationBarTitle("Регистрация", displayMode: .inline)
            .navigationBarItems(trailing: Button("Закрыть") {
                self.presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
