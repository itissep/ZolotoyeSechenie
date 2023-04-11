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
    
}
