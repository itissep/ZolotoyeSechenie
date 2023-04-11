//
//  NotificationServiceDescription.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 11.04.2023.
//

import Foundation

protocol NotificationServiceDescription {
    func getAllNotifications(for userId: String, _ completion: @escaping (Result<[UserNotification], Error>) -> Void)
    func getNotification(for notificationId: String, _ completion: @escaping (Result<UserNotification, Error>) -> Void)
}
