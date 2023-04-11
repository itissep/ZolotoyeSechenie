//
//  UserNotification.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 22.01.2023.
//

import Foundation

struct UserNotification: Codable {
    let id: String
    let title: String
    let message: String
    let image: String?
    let date: Date
    #warning("TODO: type for next screen?")
    
    init(id: String, title: String, message: String, image: String?, date: Date) {
        self.id = id
        self.title = title
        self.message = message
        self.image = image
        self.date = date
    }
    
    init(from cachedModel: UserNotificationMO) {
        self.id = cachedModel.id ?? ""
        self.title = cachedModel.title ?? ""
        self.message = cachedModel.message ?? ""
        self.image = cachedModel.image
        self.date = cachedModel.date ?? Date(timeIntervalSince1970: 12345)
    }
}
