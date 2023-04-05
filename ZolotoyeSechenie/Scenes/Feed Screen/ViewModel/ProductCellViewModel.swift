//
//  ProductCellViewModel.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 21.01.2023.
//

import Foundation

struct ProductCellViewModel: ProductCellViewModelProtocol {
    let id: String
    let title: String
    let description: String
    let amount: String
    let image: String?
    let price: String
    
    init(from model: Product){
        self.id = model.id
        self.title = model.name
        self.description = model.description
        self.amount = model.amount
        self.image = model.imageUrl
        self.price = "\(model.price)"
    }
    
    #warning("TODO: price converter")
    #warning("TODO: image loading ????")
}

//
//struct FeedCollectionsViewModel {
//    var careProgramms: [MockData.CareProgramms] = []
//    var cosmeticCategories: [MockData.DecorativeCategories] = []
//    var specialProducts: [MockData.SpecialProducts] = []
//}
