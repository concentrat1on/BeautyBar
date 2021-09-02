//
//  NewsModel.swift
//  BeautyBar
//
//  Created by Илья on 30.08.2021.
//

import Foundation

struct FBNews: Identifiable, Codable {
    var id: Int
    let title: String
    let imageURL: String
    
    init(id: Int, title: String, imageURL: String) {
        self.id = id
        self.title = title
        self.imageURL = imageURL
    }
}

extension FBNews {
    init?(documentData: [String : Any]) {
        let id = documentData[FBKeys.News.id] as? Int ?? 0
        let title = documentData[FBKeys.News.title] as? String ?? ""
        let imageURL = documentData[FBKeys.News.imageURL] as? String ?? ""
        
        // Make sure you also initialize any app specific properties if you have them

        
        self.init(id: id,
                  title: title,
                  imageURL: imageURL
                  // Dont forget any app specific ones here too
        )
    }
}
