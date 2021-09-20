//
//  FBFireStore.swift
//  Signin With Apple
//
//  Created by Stewart Lynch on 2020-03-18.
//  Copyright © 2020 CreaTECH Solutions. All rights reserved.
//
import FirebaseFirestore


enum FBFirestore {

    // MARK: - Func to retrieve News for HomeView
    
    static func retrieveServices(key: String, completion: @escaping (Result<[FBServices], Error>) -> ()) {
        Firestore.firestore()
            .collection(FBKeys.CollectionPath.services)
            .whereField("service", isEqualTo: key)
            .getDocuments { (snapshot, err) in
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
                }
                )))
            }
    }
    
    static func addService(service: String,
                           title: String,
                           text: String, uid: String) {
        let id = Int.random(in: 1...999999999999999999)
        let date = Date()
        Firestore.firestore()
            .collection(FBKeys.CollectionPath.services)
            .document("\(id)")
            .setData([ "id" : id,
                       "service" : service,
                       "title" : title,
                       "text" : text,
                       "date" : date,
                       "uid" : uid
            ])
        print(id, service, title, text, date)
    }
    
    static func retrieveFBNews(completion: @escaping (Result<[FBNews], Error>) -> ()) {
        Firestore.firestore()
            .collection(FBKeys.CollectionPath.news)
            .getDocuments { (snapshot, err) in
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
    
 /*   fileprivate static func addSnapshotListener(for reference: DocumentReference, completion: @escaping (Result<[String: Any], Error>) -> ()) {
        reference.addSnapshotListener { documentSnapshot, err in
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
 */
}