//
//  FavoritesModel.swift
//  BeautyBar
//
//  Created by Илья on 13.09.2021.
//

import SwiftUI
import RealmSwift

class FavoritesModel: ObservableObject {
    
    @Published var services: [RealmServices] = []
    
    init() {
        fetchData()
    }
    
    func contains(_ object: Int) -> Bool {
        guard let realm = try? Realm() else {
            return false
        }
        
        return realm.object(ofType: RealmServices.self, forPrimaryKey: object) != nil

    }
    
    func fetchData() {
        guard let realm = try? Realm() else {
            return
        }
        let results = realm.objects(RealmServices.self)
        print(results)
        self.services = results.compactMap { (service) -> RealmServices in
            return service
        }
    }
    
    func addData(_ object: FBServices) {
        let data = RealmServices()
        data.id = object.id
        data.section = object.service
        data.title = object.title
        data.text = object.text
        data.date = object.date
        
        guard let realm = try? Realm() else {
            return
        }
        try? realm.write {
            realm.add(data)
            fetchData()
        }
    }
    
    func deleteData(_ object: FBServices) {
        
        let data = RealmServices()
        data.id = object.id
        data.section = object.service
        data.title = object.title
        data.text = object.text
        data.date = object.date
        
        guard let realm = try? Realm() else {
            return
        }
        try? realm.write {
            let result = realm.objects(RealmServices.self)
            realm.delete(result)
            fetchData()
        }
    }
}

class RealmServices: Object, Identifiable {
    
    @Persisted var id = 0
    @Persisted var section = ""
    @Persisted var title = ""
    @Persisted var text =  ""
    @Persisted var date = Date()
    
    override static func primaryKey() -> String {
        return "id"
    }
}
