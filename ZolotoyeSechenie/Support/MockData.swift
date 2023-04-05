//
//  MockData.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 21.01.2023.
//

import UIKit

// or json from server?

protocol CollectionableMock {
    var id: String { get }
    var title: String { get }
    var image: UIImage? { get }
}

struct MockData {
    static let user = User(id: "userId", name: "Аноним", imageUrl: "iamgeUrl")
    
    static let product = Product(
        id: "productId",
        name: "Cool product",
        imageUrl: "imageUrl",
        price: 1300,
        amount: "10 ml",
        description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
        ingredients: ["sugar", "milk", "eggs"],
        categories: ["sugar", "milk", "eggs"])
    
    static let products = [product,
                           Product(id: "2"),
                           Product(id: "3"),
                           Product(id: "4"),
                           Product(id: "5"),
                           Product(id: "6"),]
    
    static let collection = ProductCollection(
        id: "1",
        title: "Main Category",
        description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
        imageUrl: "imageUrl",
        productsId: ["2", "4", "5"])
    
    static let collections = [
        collection,
        ProductCollection(id: "2"),
        ProductCollection(id: "3"),
        ProductCollection(id: "4"),
    ]
    
    static let address = Address(
        id: "1",
        city: "Wonderland",
        district: "Red-light",
        street: "White",
        building: "1",
        apartment: "228 A")
    
    static var addresses = [address,
                            Address(id: "one", city: "one", district: "one", street: "one", building: "one", apartment: "one"),
                            Address(id: "two", city: "two", district: "two", street: "two", building: "two", apartment: "two")]
    
    
    struct CareProgramms: CollectionableMock {
        let id: String
        let title: String
        let image: UIImage?
        
        static let all = [
            CareProgramms(id: "first", title: "First Category", image: UIImage(named: "1")),
            CareProgramms(id: "second", title: "second Category", image: UIImage(named: "2")),
            CareProgramms(id: "third", title: "third Category", image: UIImage(named: "3")),
            CareProgramms(id: "forth", title: "forth Category", image: UIImage(named: "4")),
            CareProgramms(id: "fifth", title: "fifth Category", image: UIImage(named: "5")),
        ]
    }

    struct DecorativeCategories {
        let id: String
        let image: UIImage?
        
        static let all = [
            DecorativeCategories(id: "first", image: UIImage(named: "1")),
            DecorativeCategories(id: "second", image: UIImage(named: "2")),
            DecorativeCategories(id: "third", image: UIImage(named: "3")),
            DecorativeCategories(id: "forth", image: UIImage(named: "4")),
            DecorativeCategories(id: "fifth", image: UIImage(named: "5")),
            DecorativeCategories(id: "sixth", image: UIImage(named: "6")),
            DecorativeCategories(id: "seventh", image: UIImage(named: "7")),
        ]
    }


    struct SpecialProducts: CollectionableMock {
        let id: String
        let title: String
        let image: UIImage?
        
        static let all = [
            SpecialProducts(id: "first", title: "First Category", image: UIImage(named: "1")),
            SpecialProducts(id: "second", title: "second Category", image: UIImage(named: "2")),
            SpecialProducts(id: "third", title: "third Category", image: UIImage(named: "3")),
        ]
    }
    
    struct Addresses {
        static var model = [Address(id: "one", city: "one", district: "one", street: "one", building: "one", apartment: "one"), Address(id: "two", city: "two", district: "two", street: "two", building: "two", apartment: "two")]
    }
}
