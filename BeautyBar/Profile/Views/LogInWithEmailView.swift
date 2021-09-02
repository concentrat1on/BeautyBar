//
//  LogInWithEmailView.swift
//  BeautyBar
//
//  Created by Илья on 15.08.2021.
//

import SwiftUI

struct LogInWithEmailView: View {
    @EnvironmentObject var userInfo: UserInfo
    @State var user: UserViewModel = UserViewModel()
    @Binding var showSheet: Bool
    @Binding var action: LoginView.Action?
    
    @State private var showAlert = false
    @State private var authError: EmailAuthError?
    
    var opacity: Double {
        user.isLogInComplete ? 1 : 0.5
    }
    
    var body: some View {
        VStack {
            TextField("Email адрес", text: self.$user.email)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
                .padding(5)
                .font(Font.system(size: 17, weight: .medium, design: .monospaced))
                .overlay(
                    RoundedRectangle(
                        cornerRadius: 10)
                        .stroke(Color.black,
                                lineWidth: 1)
                )
            
            SecureField("Пароль", text: self.$user.password)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .padding(5)
                .font(Font.system(size: 17, weight: .medium, design: .monospaced))
                .overlay(
                    RoundedRectangle(
                        cornerRadius: 10)
                        .stroke(Color.black,
                                lineWidth: 1)
                )
            HStack {
                Spacer()
                Button("Забыли пароль?") {
                    self.action = .resetPassword
                    self.showSheet = true
                }
                .padding(.bottom)
            }
            HStack(spacing: 30) {
                
                ButtonView(
                    width: 150,
                    height: 50,
                    text: "Войти",
                    color: .white,
                    frameColor: .black,
                    opacity: opacity) {
                    FBAuth.authenticate(withEmail: self.user.email,
                                        password: self.user.password) { result in
                        switch result {
                        case .failure(let error):
                            self.authError = error
                            self.showAlert = true
                        case .success( _):
                            print("Вы успешно вошли")
                        }
                    }
                } .disabled(!user.isLogInComplete)
                
                ButtonView(
                    width: 150,
                    height: 50,
                    text: "Регистрация",
                    color: .black,
                    frameColor: .white,
                    opacity: 1) {
                    self.action = .signUp
                    self.showSheet = true
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Ошибка входа"),
                    message: Text("\(self.authError?.localizedDescription ?? "Неизвестная ошибка")"),
                    dismissButton: .default(Text("OK")) {
                        if self.authError == .incorrectPassword {
                            self.user.password = ""
                        } else {
                            self.user.password = ""
                            self.user.email = ""
                        }
                    })
            }
        }
        .padding(.top, 100)
        .frame(width: 350)
        .textFieldStyle(RoundedBorderTextFieldStyle())
    }
}

struct LogInWithEmailView_Previews: PreviewProvider {
    static var previews: some View {
        LogInWithEmailView(showSheet: .constant(false), action: .constant(.signUp))
    }
}
