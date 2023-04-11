//
//  NotificationsViewModel.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 22.01.2023.
//

import Foundation
import Combine

class NotificationsViewModel: NSObject {
    
    private var notificationsService: NotificationServiceDescription
    private let userId: String
    private let coordinator: NotificationsCoordinatorDescription
    
    @Published var notificationCellViewModels = [NotificationCellViewModel]()
    @Published var isLoading = false
    
    init(userId: String, notificationsService: NotificationServiceDescription, coordinator: NotificationsCoordinatorDescription) {
        self.notificationsService = notificationsService
        self.userId = userId
        self.coordinator = coordinator
        super.init()
        
        isLoading = true
        getNotifications()
    }
    
    func getNotifications() {
        notificationsService.getAllNotifications(for: userId) {[weak self] result in
            switch result {
            case .failure(let error):
                print(error)
                self?.isLoading = false
                #warning("TODO: add error handler")
            case .success(let notifications):
                self?.fetchData(notifications: notifications)
            }
        }
    }
    
    func fetchData(notifications: [UserNotification]) {
        var vms = [NotificationCellViewModel]()
        for notification in notifications {
            vms.append(createCellModel(notification: notification))
        }
        notificationCellViewModels = vms
        isLoading = false
    }
    
    func createCellModel(notification: UserNotification) -> NotificationCellViewModel {
        return NotificationCellViewModel(from: notification)
    }
    
    func reloadData() {
        getNotifications()
    }
}
