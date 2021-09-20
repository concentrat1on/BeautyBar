//
//  UserInfo.swift
//  BeautyBar
//
//  Created by Илья on 15.08.2021.
//

import Foundation
import FirebaseAuth

class UserInfo: ObservableObject {
    enum FirebaseAuthState {
        case undefined
        case signedIn
        case signedOut
    }
    
    @Published var isUserAuntheticated: FirebaseAuthState = .undefined
    @Published var user: FBUser = .init(uid: "", name: "", email: "", city: "", bool: false)
    
    var authStateDidChangeListenerHandle: AuthStateDidChangeListenerHandle?
    
    func configureFirebaseStateDidChange() {
        authStateDidChangeListenerHandle = Auth.auth().addStateDidChangeListener({ _, user in
            guard let _ = user else {
                self.isUserAuntheticated = .signedOut
                return
            }
            self.isUserAuntheticated = .signedIn
/*            FBFirestore.retrieveFBUser(uid: user.uid) { result in
                switch result {
                case .failure(let error):
                    print(error.localizedDescription)
                case.success(let user):
                    self.user = user
                }
            }
 */
        })
    }
}
