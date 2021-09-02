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
    }
    
    enum User {
        static let uid = "uid"
        static let name = "name"
        static let email = "email"
        static let city = "city"
        
        // Add app specific keys here
    }
    
    enum News {
        static let id = "id"
        static let title = "title"
        static let imageURL = "imageURL"
    }
}
