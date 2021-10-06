//
//  AddServiceView.swift
//  BeautyBar
//
//  Created by Илья on 17.09.2021.
//

import SwiftUI
import MapKit


struct AddServiceView: View {
    
    @EnvironmentObject var userInfo: UserInfo
    @Environment(\.presentationMode) var presentationMode
    @State var addService = AddServiceViewModel()
    @State private var showPhotoPicker = false
    
    // Alerts
    @State private var showAddAlert = false
    @State private var showSuccessAlert = false
    @State private var showFailureAlert = false
    
    
    private let color = Color.init(
        red: Double.random(in: 0.1...0.9),
        green: Double.random(in: 0.1...0.9),
        blue: Double.random(in: 0.1...0.9)
    )
    
    var body: some View {
        Form {
            // Photo Picker

                        VStack {
                            Image(uiImage: addService.image)
                                .resizable()
                                .scaledToFit()
                                .frame(
                                    width: UIScreen.main.bounds.width / 2.5,
                                    height: UIScreen.main.bounds.width / 2.5)
                                .background(color)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .shadow(color: color, radius: 10)
                                .padding(10)
                                .onTapGesture {
                                    showPhotoPicker.toggle()
                                }
                            Text("Добавьте фото")
                                .font(.system(size: 20))
                                .fontWeight(.medium)
                        }
                        .padding(.top, 10)
                
            
            .listRowInsets(EdgeInsets())
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .background(Color("FormColor"))
            
            // Title, service and city selection
            Section {
                TextField("Название", text: $addService.title)
                TextField("Цена", text: $addService.price)
                    .keyboardType(.numberPad)
                Picker("Услуга", selection: $addService.service) {
                    ForEach(addService.serviceSelection, id: \.self) {
                        Text($0)
                    }
                }
                Picker("Город", selection: $addService.city) {
                    ForEach(addService.citySelection, id: \.self) {
                        Text($0)
                    }
                }
            }
            
            // PhoneNumber and email
            Section {
                TextField("Номер телефона", text: $addService.phoneNumber)
                    .keyboardType(.numberPad)
                TextField("Почта", text: $addService.email)
            }
            
            // Description
            Section {
                MultilineTextField("Описание", text: $addService.text)
            }
            
            // UIKit alerts with results of publishing service
            if self.showSuccessAlert {
                AlertControlView(showAlert: $showSuccessAlert,
                                 title: "Получилось 😎",
                                 message: "Ваша услуга будет опубликована через пару секунд")
            }
            if self.showFailureAlert {
                AlertControlView(showAlert: $showFailureAlert,
                                 title: "Не получилось 😱",
                                 message: "У вас слишком большое количество услуг, необходимо удалить хотя бы одно")
            }
            
        }
            
        .onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            addService.isFieldsFilled ?
            Button("Опубликовать") {
                self.showAddAlert.toggle() } :
            nil
        }
        // SwiftUI alert
        .alert(isPresented: $showAddAlert) {
            Alert(title: Text("Добавление услуги"),
                  message: Text("Вы удостоверились в корректности ваших данных?"),
                  primaryButton: .destructive(Text("Да")) {
                FBFirestore.addService(uid: userInfo.user.uid, image: addService.image, title: addService.title, price: Int(addService.price) ?? 0, service: addService.service, city: addService.city, phoneNumber: addService.phoneNumber, email: addService.email, text: addService.text) { result in
                    switch result {
                    case .success(let int) :
                        if int == 1 {
                            self.showSuccessAlert.toggle()
                        } else {
                            self.showFailureAlert.toggle()
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                presentationMode.wrappedValue.dismiss()
            },
                  secondaryButton: .cancel(Text("Нет"))
            )}
        .sheet(isPresented: $showPhotoPicker) {
            PhotoPicker(selectedImage: $addService.image)
        }
        
    }
            
}

struct AddServiceView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddServiceView()
        }
    }
}
