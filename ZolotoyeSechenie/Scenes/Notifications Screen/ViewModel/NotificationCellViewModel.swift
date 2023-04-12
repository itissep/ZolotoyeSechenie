//
//  NotificationCellViewModel.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 22.01.2023.
//

import Foundation

struct NotificationCellViewModel: GenericCellViewModelProtocol {
    let id: String
    let title: String
    let message: String
    let date: Date
    let image: String?
    
    init(id: String, title: String, message: String, date: Date, image: String?) {
        self.id = id
        self.title = title
        self.message = message
        self.date = date
        self.image = image
    }
    
    init(from model: UserNotification) {
        self.id = model.id
        self.message = model.message
        self.date = model.date
        self.image = model.image
        self.title = model.title
    }
}
