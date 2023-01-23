//
//  ProductCellViewModel.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 21.01.2023.
//

import Foundation

struct ProductCellViewModel: ProductCellViewModelProtocol {
    
    var id: String
    var title: String = "Some title"
    var description: String = "Some description"
    var amount: String = "15 ml"
    var image: String? = "1"
    var price: String = "1500 руб."
}


struct FeedCollectionsViewModel {
    var careProgramms: [MockData.CareProgramms] = []
    var cosmeticCategories: [MockData.DecorativeCategories] = []
    var specialProducts: [MockData.SpecialProducts] = []
}
