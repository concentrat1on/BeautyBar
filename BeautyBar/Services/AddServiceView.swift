//
//  AddServiceView.swift
//  BeautyBar
//
//  Created by Илья on 17.09.2021.
//

import SwiftUI

struct AddServiceView: View {
    @EnvironmentObject var userInfo: UserInfo
    
    var body: some View {
        Button("Hello") {
            FBFirestore.addService(service: "MakeUp", title: "Hello", text: "Hello", uid: userInfo.user.uid)
        }
    }
}

struct AddServiceView_Previews: PreviewProvider {
    static var previews: some View {
        AddServiceView()
    }
}
