//
//  MockNotificationService.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 03.04.2023.
//

import Foundation

final class MockNotificationService: NotificationServiceDescription {
    func getAllNotifications(for userId: String, _ completion: @escaping (Result<[UserNotification], Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            
        }
    }
    
    func getNotification(for notificationId: String, _ completion: @escaping (Result<UserNotification, Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            
        }
    }
}
