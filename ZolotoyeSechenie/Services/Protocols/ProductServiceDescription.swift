//
//  ProductServiceDescription.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 11.04.2023.
//

import Foundation


protocol ProductServiceDescription {
    func getProduct(with productId: String, _ completion: @escaping (Result<Product, Error>) -> Void)
    func getAllProducts(for collectionId: String?, _ completion: @escaping (Result<[Product], Error>) -> Void)
    func getCollections(for type: CollectionType, _ completion: @escaping (Result<[ProductCollection], Error>) -> Void)
    // find product by name
    // categories
}
