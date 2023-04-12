//
//  OrderCellViewModel.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 23.01.2023.
//

import Foundation

struct OrderCellViewModel: GenericCellViewModelProtocol {
    let id: String
    let title: String = "Заказ Номер"
    let message: String = "Статус заказа"
    let date: Date = Date(timeIntervalSince1970: 12345)
    let image: String? = "5"
    // TODO: date to string converter
    
}
