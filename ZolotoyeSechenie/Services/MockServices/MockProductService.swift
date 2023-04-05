//
//  MockProductService.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 03.04.2023.
//

import Foundation

final class MockProductService: ProductServiceDescription {
    func getProduct(with productId: String, _ completion: @escaping (Result<Product, Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            completion(.success(MockData.product))
//            completion(.failure(ServiceError.productInfoFailture))
        }
    }
    
    func getAllProducts(for collectionId: String?, _ completion: @escaping (Result<[Product], Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            completion(.success(MockData.products))
//            completion(.failure(ServiceError.productsFetchFailture))
        }
    }
    
    func getCollections(for type: CollectionType, _ completion: @escaping (Result<[ProductCollection], Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            completion(.success(MockData.collections))
        }
    }
    
    
}
