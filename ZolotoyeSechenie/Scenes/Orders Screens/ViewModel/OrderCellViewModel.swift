//
//  OrderCellViewModel.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 23.01.2023.
//

import Foundation

struct OrderCellViewModel: ProductCellProtocol {
    let id: String
    let title: String = "Заказ Номер"
    let message: String = "Статус заказа"
    let date: String = "сегодня в 18:00"
    let image: String? = "5"
    // TODO: date to string converter
    
}
