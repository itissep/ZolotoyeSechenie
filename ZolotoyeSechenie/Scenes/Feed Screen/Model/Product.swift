//
//  Product.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 21.01.2023.
//

import Foundation


typealias Products = [Product]

struct Product: Codable {
    let id: String
    let name: String
    let imageUrl: String?
    let price: Double
    let amount: String // ???
    let description: String
    let ingredients: [String]
    let categories: [String] // categories Id ???
    
    init(id: String, name: String, imageUrl: String?, price: Double, amount: String, description: String, ingredients: [String], categories: [String]) {
        self.id = id
        self.name = name
        self.imageUrl = imageUrl
        self.price = price
        self.amount = amount
        self.description = description
        self.ingredients = ingredients
        self.categories = categories
    }
    
    init(id: String) {
        self.id = id
        self.name = "Some name"
        self.imageUrl = "imageUrl"
        self.price = 1500
        self.amount = "15 ml"
        self.description = "Long and extremely special description of this unique product."
        self.ingredients = ["one","two","three"]
        self.categories = ["one","two","three"]
    }
}
