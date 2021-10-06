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
    @State private var showPhotoPicker = false
    @State private var showGoodAnimation = false
    let citySelection = ["Киев", "Днепр"]
    
    var color: Color {
        user.isSignUpIsComplete ? .green : .red
    }
    
    var body: some View {
        NavigationView {
        Form {
            VStack {
                Image(uiImage: user.profilePhoto)
                    .resizable()
                    .scaledToFit()
                    .frame(
                        width: UIScreen.main.bounds.width / 3,
                        height: UIScreen.main.bounds.width / 3)
                    .background(Color.gray)
                    .clipShape(Circle())
                    .shadow(color: Color.black, radius: 9)
                    .padding(10)
                    .onTapGesture {
                        showPhotoPicker.toggle()
                    }
                if !user.filledPhotoAndFullname {
                    Text("Добавьте фото")
                        .font(.system(size: 20))
                        .fontWeight(.medium)
                } else {
                    Text("\(user.fullName)")
                        .font(.system(size: 20))
                        .fontWeight(.medium)
                }
            }
            .padding(.top, 10)
            .listRowInsets(EdgeInsets())
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .background(Color("FormColor"))
            Section {
                HStack {
                    Image(systemName: "person")
                    Divider()
                    TextField("Email", text: $user.email) }
                
                HStack {
                    Image(systemName: "lock")
                    Divider()
                    SecureField("Пароль", text: $user.password)
                }
                HStack {
                    Image(systemName: "lock")
                    Divider()
                    SecureField("Повторите пароль", text: $user.confirmPassword)
                }
                if !user.validEmailText.isEmpty {
                    Text(user.validEmailText).font(.caption).foregroundColor(.red)
                }
                if !user.validPasswordText.isEmpty {
                    Text(user.validPasswordText).font(.caption).foregroundColor(.red)
                }
                if !user.passwordMatch(ConfirmPassword: user.confirmPassword) {
                    Text(user.validConfirmPasswordText).font(.caption).foregroundColor(.red)
                }
                
            }
            Section {
                TextField("Имя", text: $user.firstName)
                TextField("Фамилия", text: $user.secondName)
                Picker("Город", selection: $user.city) {
                    ForEach(citySelection, id: \.self) {
                        Text($0)
                    }
                }
                if !user.validFullnameText.isEmpty {
                    Text(user.validFullnameText).font(.caption).foregroundColor(.red)
                }
                
            }
            
            Section {
                Toggle("Предоставляю(ем) услуги", isOn: $user.isWorkerBool.animation())
                if user.isWorkerBool {
                    Toggle("Компания", isOn: $user.isCompanyBool)
                        .animation(.easeInOut(duration: 2))
                }
            }
            
            Section {
                ButtonView(
                    width: 225,
                    height: 50,
                    text: "Зарегистрироваться",
                    color: .white,
                    frameColor: color,
                    opacity: 1) {
                    FBAuth.createUser(
                        withEmail: self.user.email,
                        firstName: self.user.firstName,
                        secondName: self.user.secondName,
                        password: self.user.password,
                        city: self.user.city,
                        isWorkerBool: self.user.isWorkerBool,
                        isCompanyBool: self.user.isCompanyBool,
                        profilePhoto: self.user.profilePhoto) { result in
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
            }
            
        }
        }
        .sheet(isPresented: $showPhotoPicker) {
            PhotoPicker(selectedImage: $user.profilePhoto)
        }
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

//        NavigationView {
//            ScrollView {
//                VStack {
//                    Group {
//                        VStack(alignment: .leading) {
//                            TextFieldView(text: self.$user.email, color: .black, placeholder: "Email адрес")
//                            if !user.validEmailText.isEmpty {
//                                Text(user.validEmailText).font(.caption).foregroundColor(.red)
//                            }
//                        }
//                        VStack(alignment: .leading) {
//                            SecureFieldView(text: self.$user.password, color: .black, placeholder: "Пароль")
//                            if !user.validPasswordText.isEmpty {
//                                Text(user.validPasswordText).font(.caption).foregroundColor(.red)
//                            }
//                        }
//                        VStack(alignment: .leading) {
//                            SecureFieldView(text: self.$user.confirmPassword, color: .black, placeholder: "Повторите пароль")
//                            if !user.passwordMatch(ConfirmPassword: user.confirmPassword) {
//                                Text(user.validConfirmPasswordText).font(.caption).foregroundColor(.red)
//                            }
//                        }
//                        .padding(.bottom, 30)
//                        VStack(alignment: .leading) {
//                            TextFieldView(text: self.$user.fullname, color: .gray, placeholder: "Имя и Фамилия")
//                            if !user.validFullnameText.isEmpty {
//                                Text(user.validFullnameText).font(.caption).foregroundColor(.red)
//                            }
//
//                        }
//                        VStack(alignment: .leading) {
//                            TextFieldView(text: self.$user.city, color: .gray, placeholder: "Город")
//                            if !user.validCityText.isEmpty {
//                                Text(user.validCityText).font(.caption).foregroundColor(.red)
//                            }
//                        }
//                        HStack {
//                            Text("Я предоставляю услуги")
//                            Toggle("", isOn: $user.bool)
//                            Spacer()
//
//                        }
//
//                    } .frame(width: 350)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//
//                    VStack(spacing: 20) {
//                        ButtonView(
//                            width: 225,
//                            height: 50,
//                            text: "Зарегистрироваться",
//                            color: .white,
//                            frameColor: color,
//                            opacity: 1) {
//                            FBAuth.createUser(
//                                withEmail: self.user.email,
//                                name: self.user.fullname,
//                                password: self.user.password,
//                                city: self.user.city,
//                                bool: self.user.bool,
//                                profilePhoto: self.user.profilePhoto) { result in
//                                switch result {
//                                case .failure(let error):
//                                    self.errorString = error.localizedDescription
//                                    self.showError = true
//                                case .success( _):
//                                    print("Аккаунт успешно был зарегистрирован")
//                                }
//                            }
//                            }
//                        .disabled(!user.isSignUpIsComplete)
//                        Spacer()
//                    } .padding(50)
//                }
//            } .padding(.top)
//            .alert(isPresented: $showError) {
//                Alert(
//                    title: Text("Ошибка во время создания аккаунта"),
//                    message: Text(errorString),
//                    dismissButton: .default(Text("OK")))
//            }
//            .navigationBarTitle("Регистрация", displayMode: .inline)
//            .navigationBarItems(trailing: Button("Закрыть") {
//                self.presentationMode.wrappedValue.dismiss()
//            })
//        }
//    }


struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}

