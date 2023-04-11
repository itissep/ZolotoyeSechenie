//
//  NotificationsViewModel.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 22.01.2023.
//

import Foundation
import Combine

class NotificationsViewModel: NSObject {
    
    private let coreDataManager: CoreDataManagerDescrption
    private var notificationsService: NotificationServiceDescription
    private let userId: String
    private let coordinator: NotificationsCoordinatorDescription
    
    @Published var notificationCellViewModels = [NotificationCellViewModel]()
    @Published var isLoading = false
    
    init(userId: String,
         notificationsService: NotificationServiceDescription,
         coreDataManager: CoreDataManagerDescrption,
         coordinator: NotificationsCoordinatorDescription) {
        self.notificationsService = notificationsService
        self.coreDataManager = coreDataManager
        self.userId = userId
        self.coordinator = coordinator
        super.init()
        
        isLoading = true
        getCachedData()
        getNotifications()
    }
    
    private func getCachedData() {
        coreDataManager.initIfNeeded {[weak self] in
            let request = UserNotificationMO.fetchRequest()
            guard let notificationsMO = self?.coreDataManager.fetch(request: request) else { return }
            let notificationModels = notificationsMO.map { UserNotification(from: $0) }
            self?.fetchData(notifications: notificationModels)
        } errorBlock: { error in
            print(error)
            #warning("TODO: add error handler")
        }
    }
    
    private func replaceCache(with notifications: [UserNotification]) {
        coreDataManager.initIfNeeded {[weak self] in
            self?.coreDataManager.deleteAll(request: UserNotificationMO.fetchRequest())
            
            notifications.forEach { newNotification in
                self?.coreDataManager.create(entityName: EntitiesDB.UserNotificationMO.rawValue, configurationBlock: { notificationMO in
                    guard let notificationMO = notificationMO as? UserNotificationMO else { return }
                    notificationMO.id = newNotification.id
                    notificationMO.title = newNotification.title
                    notificationMO.message = newNotification.message
                    notificationMO.date = newNotification.date
                    notificationMO.image = newNotification.image
                })
            }
        } errorBlock: { error in
            print(error)
            #warning("TODO: error handler")
        }

    }
    
    func getNotifications() {
        notificationsService.getAllNotifications(for: userId) {[weak self] result in
            switch result {
            case .failure(let error):
                print(error)
                self?.isLoading = false
                #warning("TODO: add error handler")
            case .success(let notifications):
                self?.replaceCache(with: notifications)
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
