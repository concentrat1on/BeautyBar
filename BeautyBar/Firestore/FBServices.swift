//
//  FBServices.swift
//  BeautyBar
//
//  Created by Илья on 10.09.2021.
//

import Foundation
import FirebaseFirestore
import Firebase

struct FBServices: Identifiable, Codable {
    
    let id: Int
    let date: Date
    let uid: String
    let imageURL: String
    let title: String
    let price: Int
    let service: String
    let city: String
    let phoneNumber: String
    let email: String
    let text: String
    
    
    

    init(id: Int, date: Date, uid: String, imageURL: String, title: String, price: Int, service: String, city: String, phoneNumber: String, email: String, text: String) {
        self.id = id
        self.date = date
        self.uid = uid
        self.imageURL = imageURL
        self.title = title
        self.price = price
        self.service = service
        self.city = city
        self.phoneNumber = phoneNumber
        self.email = email
        self.text = text

        
    }
}

extension FBServices {
    init?(documentData: [String : Any]) {
        let id = documentData[FBKeys.Services.id] as? Int ?? 0
        let date = (documentData[FBKeys.Services.date] as? Timestamp)?.dateValue() ?? Date()
        let uid = documentData[FBKeys.Services.uid] as? String ?? ""
        let imageURL = documentData[FBKeys.Services.imageURL] as? String ?? ""
        let title = documentData[FBKeys.Services.title] as? String ?? ""
        let price = documentData[FBKeys.Services.price] as? Int ?? 0
        let service = documentData[FBKeys.Services.service] as? String ?? ""
        let city = documentData[FBKeys.Services.city] as? String ?? ""
        let phoneNumber = documentData[FBKeys.Services.phoneNumber] as? String ?? ""
        let email = documentData[FBKeys.Services.email] as? String ?? ""
        let text = documentData[FBKeys.Services.text] as? String ?? ""
        
        
        // Make sure you also initialize any app specific properties if you have them

        
        self.init(id: id,
                  date: date,
                  uid: uid,
                  imageURL: imageURL,
                  title: title,
                  price: price,
                  service: service,
                  city: city,
                  phoneNumber: phoneNumber,
                  email: email,
                  text: text
                  
                  // Dont forget any app specific ones here too
        )
    }
}
