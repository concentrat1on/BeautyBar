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
    let service: String
    let title: String
    let text: String
    let date: Date
    
    init(id: Int, service: String, title: String, text: String, date: Date) {
        self.id = id
        self.service = service
        self.title = title
        self.text = text
        self.date = date
    }
}

extension FBServices {
    init?(documentData: [String : Any]) {
        let id = documentData[FBKeys.Services.id] as? Int ?? 0
        let service = documentData[FBKeys.Services.service] as? String ?? ""
        let title = documentData[FBKeys.Services.title] as? String ?? ""
        let text = documentData[FBKeys.Services.text] as? String ?? ""
        let date = (documentData[FBKeys.Services.date] as? Timestamp)?.dateValue() ?? Date()
        
        // Make sure you also initialize any app specific properties if you have them

        
        self.init(id: id,
                  service: service,
                  title: title,
                  text: text,
                  date: date
                  
                  // Dont forget any app specific ones here too
        )
    }
}
