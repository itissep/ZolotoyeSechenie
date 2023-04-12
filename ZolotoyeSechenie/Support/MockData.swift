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
    // MARK: - User
    
    static let user = User(id: "userId", name: "Аноним", imageUrl: "iamgeUrl")
    
    // MARK: - Product
    
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
    
    // MARK: - Collection
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
    
    // MARK: - Address
    
    static let address = Address(
        id: "1",
        city: "Wonderland",
        district: "Red-light",
        street: "White",
        building: "1",
        apartment: "228 A",
        comment: "Some fantastic details about this place",
        userId: "")
    
    static var addresses = [address,
                            Address(id: "one", city: "one", district: "one", street: "one",
                                    building: "one", apartment: "one", comment: nil, userId: ""),
                            Address(id: "two", city: "two", district: "two", street: "two",
                                    building: "two", apartment: "two", comment: nil, userId: "")]
    
    // MARK: - Order
    
    static let order = Order(id: "12")
    static let orders = [
        order,
        Order(id: "12"),
        Order(id: "13"),
        Order(id: "14")
    ]

    // MARK: - Notifications
    
    static let notification = UserNotification(id: "0", title: "First Notification", message: "some greatest ever",
                                               image: nil, date: Date(timeIntervalSince1970: 12345))
    
    static let notifications = [
        notification,
        UserNotification(id: "1", title: "First Notification", message: "some greatest words  ever",
                                                   image: nil, date: Date(timeIntervalSince1970: 12345)),
        UserNotification(id: "2", title: "Second Notification", message: "some words",
                                                   image: nil, date: Date(timeIntervalSince1970: 12345)),
        UserNotification(id: "3", title: "Third Notification",
                         message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                         image: nil, date: Date(timeIntervalSince1970: 12345)),
        UserNotification(id: "4", title: "Forth Notification", message: "something",
                                                   image: nil, date: Date(timeIntervalSince1970: 12345)),
    ]
    
    
    static let ratioSelections = [
        RadioViewModel(id: "0", title: "Самовывоз",
                       capture: "Новосибирск - ул.Красный проспект, д.55. \nДругой город - ...",
                       image: UIImage(named: "storage"), isChecked: true),
        RadioViewModel(id: "1", title: "Доставка курьером", capture: nil, image: UIImage(named: "truck"), isChecked: false),
        
    ]
    
    // list of categories for search
    
    // list of cities for deliveries
    
    // addresses for take out
    
    // delievery fee
    
}
