//
//  NotificationsViewModel.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 22.01.2023.
//

import Foundation


class NotificationsViewModel: NSObject {
    
    private var notificationsService: NotificationServiceProtocol
    
    var reloadTableView: (() -> Void)?
    
    var notifications = Notifications()
    
    var notificationCellViewModels = [NotificationCellViewModel]() {
        didSet {
            reloadTableView?()
        }
    }
    
    init(notificationsService: NotificationServiceProtocol = NotificationsService()) {
        self.notificationsService = notificationsService
    }
    
    func getNotifications() {
        notificationsService.getNotifications { success, model, error in
            if success, let notifications = model {
                self.fetchData(notifications: notifications)
            } else {
                print(error!)
            }
        }
    }
    
    func fetchData(notifications: Notifications) {
        self.notifications = notifications // Cache
        var vms = [NotificationCellViewModel]()
        for notification in notifications {
            vms.append(createCellModel(notification: notification))
        }
        notificationCellViewModels = vms
    }
    
    func createCellModel(notification: UserNotification) -> NotificationCellViewModel {
        let id = notification.id
        // TODO: change data later
        return NotificationCellViewModel(id: id) // change properties
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> NotificationCellViewModel {
        return notificationCellViewModels[indexPath.row]
    }
}
