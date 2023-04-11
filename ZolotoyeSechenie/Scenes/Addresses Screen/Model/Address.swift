//
//  Address.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 23.01.2023.
//

import Foundation


typealias Addresses = [Address]

struct Address: Codable, Equatable {
    let id: String
    let city: String
    let district: String
    let street: String
    let building: String
    let apartment: String
    let comment: String?
    
    let userId: String
    
    init(id: String, city: String, district: String, street: String, building: String, apartment: String, comment: String?, userId: String) {
        self.id = id
        self.city = city
        self.district = district
        self.street = street
        self.building = building
        self.apartment = apartment
        self.comment = comment
        self.userId = userId
    }
    
    init(from cachedModel: AddressMO) {
        self.id = cachedModel.id ?? ""
        self.city = cachedModel.city ?? ""
        self.district = cachedModel.disctrict ?? ""
        self.street = cachedModel.street ?? ""
        self.building = cachedModel.building ?? ""
        self.apartment = cachedModel.apartment ?? ""
        self.comment = cachedModel.comment
        self.userId = cachedModel.userId ?? ""
    }
}
