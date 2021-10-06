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
                                key: service, object: "service", title: service)) {
                                ServiceCell(
                                    text: service,
                                    image: Image(service)
                                )
                            }
                        
                    }
                }
                .padding(.init(top: 0, leading: 10, bottom: 0, trailing: 10))
            }
            .navigationTitle("Услуги")
            
            // if user is not signed in and if he/she is not a worker he/she can not create a Service
            .toolbar {
                if userInfo.isUserAuntheticated == .signedIn && userInfo.user.isWorkerBool {
                    Button(action: { isActive = true }, label: {
                        NavigationLink(
                            destination: AddServiceView(),
                            isActive: $isActive,
                            label: {
                                Text("Добавить услугу")
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
