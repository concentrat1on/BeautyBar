//
//  FBUser.swift
//  Signin With Apple
//
//  Created by Stewart Lynch on 2020-03-18.
//  Copyright © 2020 CreaTECH Solutions. All rights reserved.
//

import Foundation

struct FBUser {
    
    let uid: String
    let firstName: String
    let secondName: String
    let email: String
    let city: String
    let isWorkerBool: Bool
    let isCompanyBool: Bool
    let profilePhotoURL: String
    
    // App Specific properties can be added here
    
    init(uid: String, firstName: String, secondName: String, email: String, city: String, isWorkerBool: Bool, isCompanyBool: Bool, profilePhotoURL: String) {
        self.uid = uid
        self.firstName = firstName
        self.secondName = secondName
        self.email = email
        self.city = city
        self.isWorkerBool = isWorkerBool
        self.isCompanyBool = isCompanyBool
        self.profilePhotoURL = profilePhotoURL
    }

}

extension FBUser {
    init?(documentData: [String : Any]) {
        let uid = documentData[FBKeys.User.uid] as? String ?? ""
        let firstName = documentData[FBKeys.User.firstName] as? String ?? ""
        let secondName = documentData[FBKeys.User.secondName] as? String ?? ""
        let email = documentData[FBKeys.User.email] as? String ?? ""
        let city = documentData[FBKeys.User.city] as? String ?? ""
        let isWorkerBool = documentData[FBKeys.User.isWorkerBool] as? Bool ?? false
        let isCompanyBool = documentData[FBKeys.User.isCompanyBool] as? Bool ?? false
        let profilePhotoURL = documentData[FBKeys.User.profilePhotoURL] as? String ?? ""
        
        // Make sure you also initialize any app specific properties if you have them

        
        self.init(uid: uid,
                  firstName: firstName,
                  secondName: secondName,
                  email: email,
                  city: city,
                  isWorkerBool: isWorkerBool,
                  isCompanyBool: isCompanyBool,
                  profilePhotoURL: profilePhotoURL
                  // Dont forget any app specific ones here too
        )
    }
    
    static func dataDict(uid: String, firstName: String, secondName: String, email: String, city: String, isWorkerBool: Bool, isCompanyBool: Bool, profilePhotoURL: String) -> [String: Any] {
        var data: [String: Any]
        
        // If name is not "" this must be a new entry so add all first time data
        if firstName != "" && secondName != "" {
            data = [
                FBKeys.User.uid: uid,
                FBKeys.User.firstName: firstName,
                FBKeys.User.secondName: secondName,
                FBKeys.User.email: email,
                FBKeys.User.city: city,
                FBKeys.User.isWorkerBool: isWorkerBool,
                FBKeys.User.isCompanyBool: isCompanyBool,
                FBKeys.User.profilePhotoURL: profilePhotoURL
                // Again, include any app specific properties that you want stored on creation
            ]
        } else {
            // This is a subsequent entry so only merge uid and email so as not
            // to overrwrite any other data.
            data = [
                FBKeys.User.uid: uid,
                FBKeys.User.email: email
            ]
        }
        return data
    }
}
