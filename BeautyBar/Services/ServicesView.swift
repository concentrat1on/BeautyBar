//
//  ServicesView.swift
//  
//
//  Created by Илья on 27.08.2021.
//

import SwiftUI

struct ServicesView: View {
    
    @State private var isActive = false
    @EnvironmentObject var userInfo: UserInfo
    
    let services = ["MakeUp", "Ногти", "Прическа мужская", "Прическа женская"]
    private let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 15) {
                    ForEach(services, id: \.self) { service in
                        NavigationLink(
                            destination: SectionServiceView(
                                service: service)) {
                                ServiceCell(
                                    text: service,
                                    image: Image(service))
                            }
                        
                    }
                }
                .padding(.init(top: 0, leading: 10, bottom: 0, trailing: 10))
            }
            .navigationTitle("Услуги")
            .toolbar {
                if userInfo.isUserAuntheticated == .undefined {
                    Text("Загрузка, подождите пожалуйста")
                } else if userInfo.isUserAuntheticated == .signedOut {
                    Text("Login please")
                } else if userInfo.isUserAuntheticated == .signedIn && userInfo.user.bool {
                    Button(action: { isActive = true }, label: {
                        NavigationLink(
                            destination: AddServiceView(),
                            isActive: $isActive,
                            label: {
                                Image(systemName: "plus")
                            })
                    })
                }
                
            }
            
        }
        
    }
}


struct ServicesView_Previews: PreviewProvider {
    static var previews: some View {
        ServicesView()
    }
}
