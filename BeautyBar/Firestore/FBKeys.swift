//
//  FBKeys.swift
//  Signin With Apple
//
//  Created by Stewart Lynch on 2020-03-18.
//  Copyright © 2020 CreaTECH Solutions. All rights reserved.
//

import Foundation
enum FBKeys {
    
    enum CollectionPath {
        static let users = "users"
        static let news = "news"
        static let services = "services"
    }
    
    enum User {
        static let uid = "uid"
        static let firstName = "firstName"
        static let secondName = "secondName"
        static let email = "email"
        static let city = "city"
        static let isWorkerBool = "isWorkerBool"
        static let isCompanyBool = "isCompanyBool"
        static let profilePhotoURL = "profilePhotoURL"
        
        // Add app specific keys here
    }
    
    enum News {
        static let id = "id"
        static let title = "title"
        static let imageURL = "imageURL"
        static let text = "text"
    }
    
    enum Services {
        static let id = "id"
        static let date = "date"
        static let uid = "uid"
        static let imageURL = "imageURL"
        static let title = "title"
        static let price = "price"
        static let service = "service"
        static let city = "city"
        static let phoneNumber = "phoneNumber"
        static let email = "email"
        static let text = "text"

    }
}
