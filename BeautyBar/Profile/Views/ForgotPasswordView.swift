//
//  ForgotPasswordView.swift
//  BeautyBar
//
//  Created by Илья on 15.08.2021.
//

import SwiftUI

struct ForgotPasswordView: View {
    
    @State var user: UserViewModel = UserViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    @State private var showAlert = false
    @State private var errorString: String?
    
    var color: Color {
        user.isEmailValid(email: user.email) ? .green : .red
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                TextFieldView(text: $user.email, color: .black, placeholder: "Введите ваш Email адрес")
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                
                ButtonView(width: 200, height: 50, text: "Восстановить", color: .white, frameColor: color, opacity: 1) {
                    FBAuth.resetPassword(email: self.user.email) { result in
                        switch result {
                        case .failure(let error):
                            self.errorString = error.localizedDescription
                        case .success( _):
                            break
                        }
                        self.showAlert = true
                    }
                }
                .disabled(!user.isEmailValid(email: user.email))
                Spacer()
            } .padding(.top)
            .frame(width: 350)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .navigationBarTitle("Восстановление пароля", displayMode: .inline)
            .navigationBarItems(trailing: Button("Закрыть") {
                self.presentationMode.wrappedValue.dismiss()
            })
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Восстановление пароля"),
                      message: Text(self.errorString ?? "На вашу почту было отправлено письмо для восстановления пароля"),
                      dismissButton: .default(Text("OK")))
            }
        }
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
