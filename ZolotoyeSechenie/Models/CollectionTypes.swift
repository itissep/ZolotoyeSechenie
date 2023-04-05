//
//  CollectionTypes.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 23.01.2023.
//

import Foundation

enum CollectionType {
case Programms, Cosmetics, Specials, all, Favourites
}


struct ProductCollection: Codable {
    let id: String
    let title: String
    let description: String
    let imageUrl: String?
    let productsId: [String]
    
    init(id: String,
         title: String,
         description: String,
         imageUrl: String?,
         productsId: [String]){
        self.id = id
        self.title = title
        self.description = description
        self.imageUrl = imageUrl
        self.productsId = productsId
    }
    
    init(id: String){
        self.id = id
        self.title = "Collection"
        self.description = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
        self.imageUrl = "imageUrl"
        self.productsId = ["2", "3", "4", "5"]
    }
}
