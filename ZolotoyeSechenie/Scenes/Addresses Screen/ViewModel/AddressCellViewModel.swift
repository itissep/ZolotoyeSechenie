//
//  AddressCellViewModel.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 23.01.2023.
//

import Foundation


struct AddressCellViewModel {
    let id: String
    let title: String
    let message: String
    let index: String
    
    init(from address: Address) {
        self.id = address.id
        self.title = "ул. \(address.street), д. \(address.building)"
        self.message = "г. \(address.city), \(address.district) р-н."
        self.index = "индекс ли?"
    }
}
