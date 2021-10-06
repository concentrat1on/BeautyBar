//
//  FBFireStore.swift
//  Signin With Apple
//
//  Created by Stewart Lynch on 2020-03-18.
//  Copyright © 2020 CreaTECH Solutions. All rights reserved.
//

import FirebaseFirestore
import FirebaseStorage
import SwiftUI


enum FBFirestore {
    
    // MARK: - Retrieve Services for SectionServiceView
    
    static func retrieveServices(object: String, key: String, completion: @escaping (Result<[FBServices], Error>) -> ()) {
        let reference = Firestore.firestore()
            .collection(FBKeys.CollectionPath.services)
            .whereField("\(object)", isEqualTo: key)
        reference.getDocuments { (snapshot, err) in
            if let err = err {
                completion(.failure(err))
                return
            }
            guard let documents = snapshot?.documents else {
                completion(.failure(FireStoreError.noDocumentSnapshot))
                return
            }
            completion(.success(documents.map( { queryDocumentSnapshot -> FBServices in
                let data = queryDocumentSnapshot.data()
                print(data)
                return FBServices(documentData: data)!
            })))
        }
    }
    
    // MARK: - Uppload service to FireBase
    
    static func addService(uid: String,
                           image: UIImage,
                           title: String,
                           price: Int,
                           service: String,
                           city: String,
                           phoneNumber: String,
                           email: String,
                           text: String,
                           completion: @escaping (Result<Int, Error>) -> ()) {
        let id = Int.random(in: 1...999999999999999999)
        let date = Date()
        var imageURL = ""
        checkServicesCapacity(uid: uid) { result in
            switch result {
            case .failure(let err):
                print(err.localizedDescription)
            case .success(let count):
                if count < 2 {
                    completion(.success(1))
                    upploadPhoto(reference: "services", id: String(id), image: image) { result in
                        switch result {
                        case .failure(let error):
                            print(error.localizedDescription)
                        case .success(let data):
                            imageURL = data
                        }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                        let reference = Firestore.firestore()
                            .collection(FBKeys.CollectionPath.services)
                            .document("\(id)")
                        reference.setData([ "id" : id,
                                            "date" : date,
                                            "uid" : uid,
                                            "imageURL" : imageURL,
                                            "title" : title,
                                            "price" : price,
                                            "service" : service,
                                            "city" : city,
                                            "phoneNumber" : phoneNumber,
                                            "email" : email,
                                            "text" : text
                                            
                                          ])
                    }
                } else if count >= 2 {
                    completion(.success(0))
                } else {
                    completion(.failure(FireStoreError.notPostedData))
                }
            }
        }
        
    }
    
    // MARK: - Delete Service from Firebase
    
    static func deleteService(reference: String, id: Int) {
        let storage = Storage.storage().reference().child("images/\(reference)/\(id)")
        storage.delete { err in
            if let err = err {
                print(err.localizedDescription)
                return
            } else {
                print("Успешно удалено фото")
            }
        }
        Firestore.firestore()
            .collection(FBKeys.CollectionPath.services)
            .document("\(id)")
            .delete { err in
                if let err = err {
                    print(err.localizedDescription)
                    return
                } else {
                    print("Документ успешно удален")
                }
            }
    }
    
    // MARK: - Retrieve Services for NewsView
    
    static func retrieveFBNews(completion: @escaping (Result<[FBNews], Error>) -> ()) {
        let reference = Firestore.firestore()
            .collection(FBKeys.CollectionPath.news)
        reference.getDocuments { (snapshot, err) in
            if let err = err {
                completion(.failure(err))
                return
            }
            guard let documents = snapshot?.documents else {
                completion(.failure(FireStoreError.noDocumentSnapshot))
                return
            }
            completion(.success(documents.map( { queryDocumentSnapshot -> FBNews in
                let data = queryDocumentSnapshot.data()
                print(data)
                return FBNews(documentData: data)!
            }
                                             )))
        }
    }
    // MARK: - These functions are aimed to retrieve/merge User
    
    static func retrieveFBUser(uid: String, completion: @escaping (Result<FBUser, Error>) -> ()) {
        let reference = Firestore
            .firestore()
            .collection(FBKeys.CollectionPath.users)
            .document(uid)
        getDocument(for: reference) { (result) in
            switch result {
            case .success(let data):
                guard let user = FBUser(documentData: data) else {
                    completion(.failure(FireStoreError.noUser))
                    return
                }
                completion(.success(user))
            case .failure(let err):
                completion(.failure(err))
            }
        }
        
    }
    
    static func mergeFBUser(_ data: [String: Any], uid: String, completion: @escaping (Result<Bool, Error>) -> ()) {
        let reference = Firestore
            .firestore()
            .collection(FBKeys.CollectionPath.users)
            .document(uid)
        reference.setData(data, merge: true) { (err) in
            if let err = err {
                completion(.failure(err))
                return
            }
            completion(.success(true))
        }
    }
    
    fileprivate static func getDocument(for reference: DocumentReference, completion: @escaping (Result<[String : Any], Error>) -> ()) {
        reference.getDocument { (documentSnapshot, err) in
            if let err = err {
                completion(.failure(err))
                return
            }
            guard let documentSnapshot = documentSnapshot else {
                completion(.failure(FireStoreError.noDocumentSnapshot))
                return
            }
            guard let data = documentSnapshot.data() else {
                completion(.failure(FireStoreError.noSnapshotData))
                return
            }
            completion(.success(data))
        }
    }
    
    // MARK: - Uppload Photo to FirebaseStorage and get URL link
    
    static func upploadPhoto(reference: String, id: String, image: UIImage, completion: @escaping (Result<String, Error>) -> ()) {
        let storage = Storage.storage().reference().child("images/\(reference)/\(id)")
        storage.putData(image.jpegData(compressionQuality: 0.3)!, metadata: nil) { _, err in
            if let err = err {
                completion(.failure(err))
            }
            
            storage.downloadURL { url, err in
                if let err = err {
                    completion(.failure(err))
                    return
                }
                
                guard let url = url else {
                    completion(.failure(FireStoreError.noSnapshotData))
                    return
                }
                print(url.absoluteString)
                completion (.success(url.absoluteString))
            }
            
        }
    }
    
    fileprivate static func checkServicesCapacity(uid: String, completion: @escaping (Result<Int, Error>) -> ()) {
        let reference = Firestore.firestore()
            .collection(FBKeys.CollectionPath.services)
            .whereField("uid", isEqualTo: uid)
        reference.getDocuments { (snapshot, err) in
            if let err = err {
                completion(.failure(err))
                return
            }
            guard let documents = snapshot?.documents else {
                completion(.failure(FireStoreError.noDocumentSnapshot))
                return
            }
            print(documents.count)
            completion(.success(documents.count))
            
        }
    }
}

