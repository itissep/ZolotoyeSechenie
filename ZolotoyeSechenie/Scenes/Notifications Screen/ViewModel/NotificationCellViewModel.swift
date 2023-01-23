//
//  NotificationCellViewModel.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 22.01.2023.
//

import Foundation

struct NotificationCellViewModel: GenericCellViewModelProtocol {
    let id: String
    let title: String = "Заказ отправлен"
    let message: String = "Вам необходимо подтвердить получение."
    let date: String = "сегодня в 18:00"
    let image: String? = "5"
    // TODO: date to string converter
    
}
