//
//  LoginView.swift
//  BeautyBar
//
//  Created by Илья on 15.08.2021.
//

import SwiftUI

struct LoginView: View {
    
    enum Action {
        case resetPassword
        case signUp

    }
    @State var showSheet = false
    @State var action: Action?
    
    var body: some View {
        LogInWithEmailView(showSheet: $showSheet, action: $action)
            .sheet(isPresented: $showSheet) { [action] in
            if action == .signUp {
               SignUpView()
              }  else  {
                ForgotPasswordView()
              }
            }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
